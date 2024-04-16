output "id" {
  description = "The ID of the Okta group rule."
  value       = okta_group_rule.this.id
}

output "name" {
  description = "The name of the Okta group rule."
  value       = okta_group_rule.this.name
}

output "enabled" {
  description = "Whether to enable the Okta Group Rule."
  value       = okta_group_rule.this.status == "ACTIVE"
}

output "expression" {
  description = "The Okta expression for Okta group rule."
  value       = okta_group_rule.this.expression_value
}

output "groups" {
  description = "The information for the assigned groups by the Okta group rule."
  value = [
    for group in data.okta_group.this :
    group.name
  ]
}

output "excluded_users" {
  description = "The list of user IDs that would be excluded when rules are processed."
  value       = okta_group_rule.this.users_excluded
}
