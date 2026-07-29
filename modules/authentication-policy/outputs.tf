output "id" {
  description = "The ID of the Okta Authentication Policy."
  value       = okta_app_signon_policy.this.id
}

output "name" {
  description = "The name of the Okta Authentication Policy."
  value       = okta_app_signon_policy.this.name
}

output "description" {
  description = "The description of the Okta Authentication Policy."
  value       = okta_app_signon_policy.this.description
}

output "rules" {
  description = "The configuration for rules of the Okta Authentication Policy."
  value = {
    for name, rule in okta_app_signon_policy_rule.this :
    name => {
      id       = rule.id
      type     = rule.system ? "SYSTEM" : "CUSTOM"
      name     = rule.name
      priority = rule.priority
      enabled  = rule.status == "ACTIVE"

      condition = {
        excluded_users      = rule.users_excluded
        included_users      = rule.users_included
        excluded_groups     = rule.groups_excluded
        included_groups     = rule.groups_included
        excluded_user_types = rule.user_types_excluded
        included_user_types = rule.user_types_included
        network = {
          scope = rule.network_connection

          excluded_zones = rule.network_excludes
          included_zones = rule.network_includes
        }
        device = {
          type = (
            rule.device_is_managed == true ? "MANAGED"
            : rule.device_is_registered == true ? "REGISTERED"
            : "ANY"
          )
          assurance_policies = rule.device_assurances_included
        }
        platforms = [
          for platform in rule.platform_include :
          {
            type          = platform.type
            os_type       = platform.os_type
            os_expression = platform.os_expression
          }
        ]
        risk_score = rule.risk_score
        expression = rule.custom_expression
      }

      allow_access = rule.access == "ALLOW"
      verification = {
        type                     = rule.type
        factor_mode              = rule.factor_mode
        reauthentication_timeout = rule.re_authentication_frequency
        inactivity_timeout       = rule.inactivity_period
        constraints              = rule.constraints
      }
      keep_me_signed_in = {
        enabled          = rule.keep_me_signed_in[0].post_auth == "ALLOWED"
        prompt_frequency = rule.keep_me_signed_in[0].post_auth_prompt_frequency
      }
    }
  }
}

# output "debug" {
#   value = {
#     for k, v in okta_app_signon_policy.this :
#     k => v
#     if !contains(["id", "name", "description"], k)
#   }
# }
