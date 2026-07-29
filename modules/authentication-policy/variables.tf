variable "name" {
  description = "(Required) A name of the Okta Authentication Policy."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) A description of the Okta Authentication Policy."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "rules" {
  description = <<EOF
  (Optional) A configuration for rules of the Okta Authentication Policy. Each item of `rules` block as defined below.
    (Required) `name` - A name of the authentication policy rule.
    (Optional) `priority` - A priority of the authentication policy rule.
    (Optional) `enabled` - Whether to enable the authentication policy rule. Defaults to `true`.
    (Optional) `condition` - A condition of the authentication policy rule. `condition` block as defined below.
      (Optional) `excluded_users` - A set of user IDs to exclude.
      (Optional) `included_users` - A set of user IDs to include.
      (Optional) `excluded_groups` - A set of group IDs to exclude.
      (Optional) `included_groups` - A set of group IDs to include.
      (Optional) `excluded_user_types` - A set of user type IDs to exclude.
      (Optional) `included_user_types` - A set of user type IDs to include.
      (Optional) `network` - A configuration for network conditions.
        (Optional) `scope` - Valid values are `ANYWHERE`, `ON_NETWORK`, `OFF_NETWORK`, or `ZONE`. Defaults to `ANYWHERE`.
        (Optional) `excluded_zones` - A set of excluded network zone IDs.
        (Optional) `included_zones` - A set of included network zone IDs.
      (Optional) `device` - A configuration for device conditions.
        (Optional) `registered` - Whether the device must be registered.
        (Optional) `managed` - Whether the device must be managed. Requires `registered` to be `true`.
        (Optional) `assurances` - A set of included device assurance policy IDs.
      (Optional) `platforms` - A set of platform conditions.
      (Optional) `risk_score` - Valid values are `ANY`, `LOW`, `MEDIUM`, or `HIGH`. Defaults to `ANY`.
      (Optional) `expression` - An Okta Expression Language condition.
    (Optional) `allow_access` - Whether to allow access. Defaults to `true`.
    (Optional) `verification` - A configuration for authentication requirements.
      (Optional) `type` - The verification method type. Valid value is `ASSURANCE`, which verifies that the selected
        factor count and constraints are satisfied. The Okta API also defines `AUTH_METHOD_CHAIN`, which prompts for
        specific authentication methods in a configured sequence, but this module doesn't support it because
        authentication method chains aren't implemented. Defaults to `ASSURANCE`.
      (Optional) `factor_mode` - Valid values are `1FA` or `2FA`. Defaults to `2FA`.
      (Optional) `reauthentication_timeout` - The maximum authentication age after which the user must re-authenticate,
        regardless of activity, in ISO 8601 duration format. Maps to `verificationMethod.reauthenticateIn` in the Okta
        Policy API and `re_authentication_frequency` in the Terraform Provider. `PT0S` means every sign-in attempt and
        Okta uses `PT43800H` to represent once per active Okta global session. Defaults to `PT43800H`.
      (Optional) `inactivity_timeout` - The duration without authentication activity after which the user must
        re-authenticate, in ISO 8601 duration format. Maps to `verificationMethod.inactivityPeriod` in the Okta Policy
        API and `inactivity_period` in the Terraform Provider. By default, no inactivity-based re-authentication is
        configured.
      (Optional) `constraints` - Knowledge and possession factor constraints.
  EOF
  type = list(object({
    name     = string
    priority = optional(number)
    enabled  = optional(bool, true)

    condition = optional(object({
      excluded_users      = optional(set(string), [])
      included_users      = optional(set(string), [])
      excluded_groups     = optional(set(string), [])
      included_groups     = optional(set(string), [])
      excluded_user_types = optional(set(string), [])
      included_user_types = optional(set(string), [])
      network = optional(object({
        scope          = optional(string, "ANYWHERE")
        excluded_zones = optional(set(string), [])
        included_zones = optional(set(string), [])
      }), {})
      device = optional(object({
        registered = optional(bool)
        managed    = optional(bool)
        assurances = optional(set(string), [])
      }), {})
      platforms = optional(set(object({
        type          = string
        os_type       = string
        os_expression = optional(string)
      })), [])
      risk_score = optional(string, "ANY")
      expression = optional(string)
    }), {})

    allow_access = optional(bool, true)
    verification = optional(object({
      type                     = optional(string, "ASSURANCE")
      factor_mode              = optional(string, "2FA")
      reauthentication_timeout = optional(string, "PT43800H")
      inactivity_timeout       = optional(string)
      constraints = optional(list(object({
        knowledge = optional(object({
          required = optional(bool, true)
          types    = optional(set(string), [])
        }))
        possession = optional(object({
          required            = optional(bool, true)
          device_bound        = optional(string)
          hardware_protection = optional(string)
          phishing_resistant  = optional(string)
          user_presence       = optional(string)
          user_verification   = optional(string)
        }))
      })), [])
    }), {})
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["ANYWHERE", "ON_NETWORK", "OFF_NETWORK", "ZONE"], rule.condition.network.scope)
    ])
    error_message = "Valid values for `condition.network.scope` are `ANYWHERE`, `ON_NETWORK`, `OFF_NETWORK`, or `ZONE`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      rule.condition.device.managed != true || rule.condition.device.registered == true
    ])
    error_message = "`condition.device.registered` must be `true` when `condition.device.managed` is `true`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["ANY", "LOW", "MEDIUM", "HIGH"], rule.condition.risk_score)
    ])
    error_message = "Valid values for `condition.risk_score` are `ANY`, `LOW`, `MEDIUM`, or `HIGH`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["1FA", "2FA"], rule.verification.factor_mode)
    ])
    error_message = "Valid values for `verification.factor_mode` are `1FA` or `2FA`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["ASSURANCE"], rule.verification.type)
    ])
    error_message = "Valid value for `verification.type` is `ASSURANCE`. `AUTH_METHOD_CHAIN` isn't supported because authentication method chains aren't implemented by this module."
  }
  validation {
    condition = alltrue(flatten([
      for rule in var.rules : [
        for constraint in rule.verification.constraints :
        constraint.possession == null || alltrue([
          for value in [
            constraint.possession.device_bound,
            constraint.possession.hardware_protection,
            constraint.possession.phishing_resistant,
            constraint.possession.user_presence,
            constraint.possession.user_verification,
          ] :
          value == null || contains(["OPTIONAL", "REQUIRED"], value)
        ])
      ]
    ]))
    error_message = "Possession constraint values must be `OPTIONAL` or `REQUIRED`."
  }
}
