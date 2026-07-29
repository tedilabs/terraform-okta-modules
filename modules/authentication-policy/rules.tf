###################################################
# Rules of Okta Authentication Policy
###################################################

resource "okta_app_signon_policy_rule" "this" {
  for_each = {
    for rule in var.rules :
    rule.name => rule
  }

  policy_id = okta_app_signon_policy.this.id

  name     = each.key
  priority = each.value.priority
  status   = each.value.enabled ? "ACTIVE" : "INACTIVE"


  ## Conditions
  users_excluded = each.value.condition.excluded_users
  users_included = each.value.condition.included_users

  groups_excluded = each.value.condition.excluded_groups
  groups_included = each.value.condition.included_groups

  user_types_excluded = each.value.condition.excluded_user_types
  user_types_included = each.value.condition.included_user_types

  network_connection = each.value.condition.network.scope
  network_excludes = (each.value.condition.network.scope == "ZONE" && length(each.value.condition.network.excluded_zones) > 0
    ? each.value.condition.network.excluded_zones
    : null
  )
  network_includes = (each.value.condition.network.scope == "ZONE" && length(each.value.condition.network.included_zones) > 0
    ? each.value.condition.network.included_zones
    : null
  )

  device_is_registered       = each.value.condition.device.type == "ANY" ? null : true
  device_is_managed          = each.value.condition.device.type == "ANY" ? null : each.value.condition.device.type == "MANAGED"
  device_assurances_included = each.value.condition.device.assurance_policies

  dynamic "platform_include" {
    for_each = each.value.condition.platforms

    content {
      type          = platform_include.value.type
      os_type       = platform_include.value.os_type
      os_expression = platform_include.value.os_expression
    }
  }

  risk_score        = each.value.condition.risk_score
  custom_expression = each.value.condition.expression


  ## Effects
  access = each.value.allow_access ? "ALLOW" : "DENY"

  type                        = each.value.verification.type
  factor_mode                 = each.value.verification.factor_mode
  re_authentication_frequency = each.value.verification.reauthentication_timeout
  inactivity_period           = each.value.verification.inactivity_timeout

  constraints = [
    for constraint in each.value.verification.constraints :
    jsonencode({
      for type, value in {
        knowledge = constraint.knowledge == null ? null : {
          required = constraint.knowledge.required
          types    = constraint.knowledge.types
        }
        possession = constraint.possession == null ? null : merge(
          {
            required = constraint.possession.required
          },
          constraint.possession.device_bound == null ? {} : {
            deviceBound = constraint.possession.device_bound
          },
          constraint.possession.hardware_protection == null ? {} : {
            hardwareProtection = constraint.possession.hardware_protection
          },
          constraint.possession.phishing_resistant == null ? {} : {
            phishingResistant = constraint.possession.phishing_resistant
          },
          constraint.possession.user_presence == null ? {} : {
            userPresence = constraint.possession.user_presence
          },
          constraint.possession.user_verification == null ? {} : {
            userVerification = constraint.possession.user_verification
          },
        )
      } : type => value
      if value != null
    })
  ]

  dynamic "keep_me_signed_in" {
    for_each = each.value.keep_me_signed_in == null ? [] : [each.value.keep_me_signed_in]

    content {
      post_auth                  = keep_me_signed_in.value.post_auth
      post_auth_prompt_frequency = keep_me_signed_in.value.prompt_frequency
    }
  }
}
