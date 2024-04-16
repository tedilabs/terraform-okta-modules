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
  description = "The list of group ids to assign the users to."
  value       = okta_group_rule.this.group_assignments
}

output "excluded_users" {
  description = "The list of user IDs that would be excluded when rules are processed."
  value       = okta_group_rule.this.users_excluded
}
