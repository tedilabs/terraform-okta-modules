locals {
  native_platform_os_types = toset([
    "ANDROID",
    "ANY",
    "CHROMEOS",
    "IOS",
    "MACOS",
    "OTHER",
    "WINDOWS",
  ])

  device_condition = {
    "ANY" = {
      registered = null
      managed    = null
    }
    "REGISTERED" = {
      registered = true
      managed    = false
    }
    "MANAGED" = {
      registered = true
      managed    = true
    }
  }
}


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

  device_is_registered       = local.device_condition[each.value.condition.device.type].registered
  device_is_managed          = local.device_condition[each.value.condition.device.type].managed
  device_assurances_included = each.value.condition.device.assurance_policies

  dynamic "platform_include" {
    for_each = concat(
      [
        for os_type in each.value.condition.platform.included_os_types.desktop :
        {
          type    = "DESKTOP"
          os_type = os_type
        }
      ],
      [
        for os_type in each.value.condition.platform.included_os_types.mobile :
        {
          type    = "MOBILE"
          os_type = os_type
        }
      ],
    )

    content {
      type          = platform_include.value.type
      os_type       = contains(local.native_platform_os_types, platform_include.value.os_type) ? platform_include.value.os_type : "OTHER"
      os_expression = contains(local.native_platform_os_types, platform_include.value.os_type) ? null : platform_include.value.os_type
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
          for key, value in {
            required = coalesce(
              constraint.knowledge.required,
              length(constraint.knowledge.excluded_authentication_methods) == 0,
            )
            types = [for type in constraint.knowledge.types : lower(type)]
            authenticationMethods = [
              for authentication_method in constraint.knowledge.authentication_methods : {
                for key, value in {
                  id     = authentication_method.id
                  key    = authentication_method.key
                  method = authentication_method.method
                } : key => value
                if value != null
              }
            ]
            excludedAuthenticationMethods = [
              for authentication_method in constraint.knowledge.excluded_authentication_methods : {
                for key, value in {
                  id     = authentication_method.id
                  key    = authentication_method.key
                  method = authentication_method.method
                } : key => value
                if value != null
              }
            ]
            reauthenticateIn = constraint.knowledge.reauthentication_timeout
          } : key => value
          if value != null
        }
        possession = constraint.possession == null ? null : {
          for key, value in {
            required = coalesce(
              constraint.possession.required,
              length(constraint.possession.excluded_authentication_methods) == 0,
            )
            deviceBound        = constraint.possession.device_bound
            hardwareProtection = constraint.possession.hardware_protection
            phishingResistant  = constraint.possession.phishing_resistant
            userPresence       = constraint.possession.user_presence
            userVerification   = constraint.possession.user_verification
            authenticationMethods = [
              for authentication_method in constraint.possession.authentication_methods : {
                for key, value in {
                  id     = authentication_method.id
                  key    = authentication_method.key
                  method = authentication_method.method
                } : key => value
                if value != null
              }
            ]
            excludedAuthenticationMethods = [
              for authentication_method in constraint.possession.excluded_authentication_methods : {
                for key, value in {
                  id     = authentication_method.id
                  key    = authentication_method.key
                  method = authentication_method.method
                } : key => value
                if value != null
              }
            ]
            reauthenticateIn = constraint.possession.reauthentication_timeout
          } : key => value
          if value != null
        }
      } : type => value
      if value != null
    })
  ]

  keep_me_signed_in {
    post_auth                  = each.value.keep_me_signed_in.enabled ? "ALLOWED" : "NOT_ALLOWED"
    post_auth_prompt_frequency = each.value.keep_me_signed_in.enabled ? each.value.keep_me_signed_in.prompt_frequency : null
  }
}
