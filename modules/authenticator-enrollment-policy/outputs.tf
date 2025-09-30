output "id" {
  description = "The ID of the Okta Authenticator Enrollment Policy."
  value       = local.policy.id
}

output "name" {
  description = "The name of the Okta Authenticator Enrollment Policy."
  value       = local.policy.name
}

output "description" {
  description = "The description of the Okta Authenticator Enrollment Policy."
  value       = local.policy.description
}

output "enabled" {
  description = "Whether the Okta Authenticator Enrollment Policy is enabled."
  value       = local.policy.status == "ACTIVE"
}

output "priority" {
  description = "The priority of the Okta Authenticator Enrollment Policy."
  value       = local.policy.priority
}

output "groups" {
  description = "The information for the assigned groups of the Okta Authenticator Enrollment Policy."
  value = [
    for group in data.okta_group.this :
    group.name
  ]
}

output "required_authenticators" {
  description = "The set of required authenticators for the Okta Authenticator Enrollment Policy."
  value       = var.required_authenticators
}

output "optional_authenticators" {
  description = "The set of optional authenticators for the Okta Authenticator Enrollment Policy."
  value       = var.optional_authenticators
}

output "rules" {
  description = "The configuration for rules of the Okta Authenticator Enrollment Policy."
  value = {
    for name, rule in okta_policy_rule_mfa.this :
    name => {
      id       = rule.id
      name     = rule.name
      priority = rule.priority
      enabled  = rule.status == "ACTIVE"

      condition = {
        excluded_users = rule.users_excluded
        network = {
          scope = rule.network_connection

          excluded_zones = rule.network_excludes
          included_zones = rule.network_includes
        }
      }
      enroll = rule.enroll
    }
  }
}

# output "debug" {
#   value = {
#     for k, v in local.mfa.this :
#     k => v
#     if !contains(["id", "name", "description"], k)
#   }
# }
