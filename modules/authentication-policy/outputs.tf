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
        platform = {
          included_os_types = {
            desktop = [
              for platform in rule.platform_include :
              platform.os_expression == null ? platform.os_type : platform.os_expression
              if platform.type == "DESKTOP"
            ]
            mobile = [
              for platform in rule.platform_include :
              platform.os_expression == null ? platform.os_type : platform.os_expression
              if platform.type == "MOBILE"
            ]
          }
        }
        risk_score = rule.risk_score
        expression = rule.custom_expression
      }

      allow_access = rule.access == "ALLOW"
      verification = {
        type                     = rule.type
        factor_mode              = rule.factor_mode
        reauthentication_timeout = rule.re_authentication_frequency
        inactivity_timeout       = rule.inactivity_period
        constraints = [
          for constraint in [
            for value in rule.constraints :
            jsondecode(value)
          ] :
          {
            knowledge = try(constraint.knowledge, null) == null ? null : {
              required = try(constraint.knowledge.required, true)
              types = toset([
                for type in try(constraint.knowledge.types, []) :
                upper(type)
              ])
              authentication_methods = toset([
                for authentication_method in try(constraint.knowledge.authenticationMethods, []) : {
                  id     = try(authentication_method.id, null)
                  key    = authentication_method.key
                  method = try(authentication_method.method, null)
                }
              ])
              excluded_authentication_methods = toset([
                for authentication_method in try(constraint.knowledge.excludedAuthenticationMethods, []) : {
                  id     = try(authentication_method.id, null)
                  key    = authentication_method.key
                  method = try(authentication_method.method, null)
                }
              ])
              reauthentication_timeout = try(constraint.knowledge.reauthenticateIn, null)
            }
            possession = try(constraint.possession, null) == null ? null : {
              required            = try(constraint.possession.required, true)
              device_bound        = try(constraint.possession.deviceBound, "OPTIONAL")
              hardware_protection = try(constraint.possession.hardwareProtection, "OPTIONAL")
              phishing_resistant  = try(constraint.possession.phishingResistant, "OPTIONAL")
              user_presence       = try(constraint.possession.userPresence, "REQUIRED")
              user_verification   = try(constraint.possession.userVerification, "OPTIONAL")
              authentication_methods = toset([
                for authentication_method in try(constraint.possession.authenticationMethods, []) : {
                  id     = try(authentication_method.id, null)
                  key    = authentication_method.key
                  method = try(authentication_method.method, null)
                }
              ])
              excluded_authentication_methods = toset([
                for authentication_method in try(constraint.possession.excludedAuthenticationMethods, []) : {
                  id     = try(authentication_method.id, null)
                  key    = authentication_method.key
                  method = try(authentication_method.method, null)
                }
              ])
              reauthentication_timeout = try(constraint.possession.reauthenticateIn, null)
            }
          }
        ]
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
