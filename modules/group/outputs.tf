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

output "admin_roles" {
  description = "The configurations for admin roles assigned to the Okta group."
  value = {
    for name, role in okta_group_role.this :
    name => {
      id                   = role.id
      role                 = name
      target_groups        = role.target_group_list
      target_apps          = role.target_app_list
      notification_enabled = !role.disable_notifications
    }
  }
}
