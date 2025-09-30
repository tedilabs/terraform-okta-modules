output "id" {
  description = "The ID of the Okta Global Session Policy."
  value       = okta_policy_signon.this.id
}

output "name" {
  description = "The name of the Okta Global Session Policy."
  value       = okta_policy_signon.this.name
}

output "description" {
  description = "The description of the Okta Global Session Policy."
  value       = okta_policy_signon.this.description
}

output "enabled" {
  description = "Whether to enable the Okta Global Session Policy."
  value       = okta_policy_signon.this.status == "ACTIVE"
}

output "priority" {
  description = "The priority of the Okta Global Session Policy."
  value       = okta_policy_signon.this.priority
}

output "groups" {
  description = "The information for the assigned groups of the Okta Global Session Policy."
  value = [
    for group in data.okta_group.this :
    group.name
  ]
}

output "rules" {
  description = "The configuration for rules of the Okta Global Session Policy."
  value = {
    for name, rule in okta_policy_rule_signon.this :
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
        authentication = {
          entrypoint        = rule.authtype
          identity_provider = rule.identity_provider
        }
      }

      allow_access   = rule.access == "ALLOW"
      primary_factor = rule.primary_factor
      mfa = {
        required                   = rule.mfa_required
        prompt_mode                = rule.mfa_prompt
        session_duration           = rule.mfa_lifetime
        remember_device_by_default = rule.mfa_remember_device
      }
      session = {
        duration                  = rule.session_lifetime
        idle_timeout              = rule.session_idle
        persistent_cookie_enabled = rule.session_persistent
      }
    }
  }
}

# output "debug" {
#   value = {
#     for k, v in okta_policy_signon.this :
#     k => v
#     if !contains(["id", "name", "description", "status", "priority", "groups_included"], k)
#   }
# }
