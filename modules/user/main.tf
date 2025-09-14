locals {
  metadata = {
    package = "terraform-okta-modules"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.email
  }
  module_tags = {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  }
}


###################################################
# Okta User
###################################################

# INFO: TODO
# - `user_type`
# INFO: Not supported attributes
# - `password`
# - `expire_password_on_create`
# - `old_password`
# - `password_inline_hook`
# - `recovery_question`
# - `recovery_answer`
# - `password hash`
resource "okta_user" "this" {
  login  = var.username
  status = var.status

  ## Name
  first_name  = var.first_name
  middle_name = var.middle_name
  last_name   = var.last_name

  honorific_prefix = var.honorific_prefix
  honorific_suffix = var.honorific_suffix

  nick_name    = var.nick_name
  display_name = var.display_name


  ## Contacts
  email        = var.email
  second_email = var.secondary_email

  mobile_phone  = var.phone
  primary_phone = var.primary_phone

  profile_url = var.profile_url


  ## Address
  country_code   = var.address_info.country_code
  state          = var.address_info.state
  city           = var.address_info.city
  street_address = var.address_info.street_address
  postal_address = var.address_info.postal_address
  zip_code       = var.address_info.zip_code


  ## Organizational Information
  employee_number = var.employee_number
  title           = var.title

  manager    = var.manager.name
  manager_id = var.manager.id

  organization = var.organization
  division     = var.division
  department   = var.department

  cost_center = var.cost_center


  ## Custom Attributes
  custom_profile_attributes           = jsonencode(var.custom_attributes)
  custom_profile_attributes_to_ignore = var.custom_attributes_to_ignore


  ## Preferences
  locale             = var.locale
  timezone           = var.timezone
  preferred_language = var.preferred_language
}


###################################################
# Roles of Okta User
###################################################

resource "okta_user_admin_roles" "this" {
  user_id = okta_user.this.id
  admin_roles = [
    for assignment in var.admin_role_assignments :
    assignment.admin_role
  ]

  disable_notifications = !var.admin_role_notification_enabled
}

resource "okta_admin_role_targets" "this" {
  for_each = {
    for assignment in var.admin_role_assignments :
    assignment.admin_role => assignment
    if length(assignment.target_groups) > 0 || length(assignment.target_apps) > 0
  }

  user_id   = okta_user.this.id
  role_type = each.key

  apps = (length(each.value.target_apps) > 0
    ? each.value.target_apps
    : null
  )
  groups = (length(each.value.target_groups) > 0
    ? each.value.target_groups
    : null
  )
}


###################################################
# Group Membership
###################################################

resource "okta_user_group_memberships" "this" {
  user_id = okta_user.this.id

  groups = var.groups
}

data "okta_group" "this" {
  for_each = toset(var.groups)

  id = each.value
}
