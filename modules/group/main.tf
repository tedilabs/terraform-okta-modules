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
    for role in var.admin_roles :
    role.role => role
  }

  group_id  = okta_group.this.id
  role_type = each.key

  target_group_list = each.value.target_groups
  target_app_list   = each.value.target_apps

  disable_notifications = !each.value.notification_enabled
}
