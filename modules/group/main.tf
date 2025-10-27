###################################################
# Okta Group
###################################################

resource "okta_group" "this" {
  name        = var.name
  description = var.description

  custom_profile_attributes = jsonencode(var.custom_profile_attributes)
}


###################################################
# Roles of Okta Group
###################################################

resource "okta_group_role" "this" {
  for_each = {
    for assignment in var.admin_role_assignments :
    assignment.admin_role => assignment
  }

  group_id  = okta_group.this.id
  role_type = each.key

  target_app_list   = each.value.target_apps
  target_group_list = each.value.target_groups

  disable_notifications = !var.admin_role_notification_enabled
}


###################################################
# Members of Okta Group
###################################################

resource "okta_group_memberships" "this" {
  group_id = okta_group.this.id

  track_all_users = var.exclusive_membership_management_enabled
  users           = var.members
}

data "okta_user" "this" {
  for_each = toset(var.members)

  user_id = each.value
}
