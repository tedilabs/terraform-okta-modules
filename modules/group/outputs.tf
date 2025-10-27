output "id" {
  description = "The ID of the Okta group."
  value       = okta_group.this.id
}

output "name" {
  description = "The name of the Okta group."
  value       = okta_group.this.name
}

output "description" {
  description = "The description of the Okta group."
  value       = okta_group.this.description
}

output "custom_profile_attributes" {
  description = "The custom profile attributes of the Okta group."
  value       = var.custom_profile_attributes
}

output "admin_role_assignments" {
  description = "The configurations for admin roles assigned to the Okta group."
  value = {
    for name, assignment in okta_group_role.this :
    name => {
      id            = assignment.id
      admin_role    = name
      target_apps   = assignment.target_app_list
      target_groups = assignment.target_group_list
    }
  }
}

output "admin_role_notification_enabled" {
  description = "Whether to send the default Okta administrator emails."
  value       = var.admin_role_notification_enabled
}

output "exclusive_membership_management_enabled" {
  description = "Whether to enable exclusive management for members of the Okta group."
  value       = var.exclusive_membership_management_enabled
}

output "members" {
  description = "The information for the group members."
  value = [
    for user in data.okta_user.this : {
      id           = user.id
      display_name = user.display_name
      email        = user.email
      login        = user.login
    }
  ]
}
