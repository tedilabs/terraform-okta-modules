variable "name" {
  description = "(Required) A name of the Okta Global Session Policy."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) A description of the Okta Global Session Policy."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "enabled" {
  description = "(Optional) Whether to enable the Okta Global Session Policy. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "priority" {
  description = "(Optional) A priority of the Okta Global Session Policy."
  type        = number
  default     = null
  nullable    = true
}

variable "groups" {
  description = "(Optional) A set of group IDs to assign the Okta Global Session Policy to."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "rules" {
  description = <<EOF
  (Optional) A configuration for rules of the Okta Global Session Policy. Each item of `rules` block as defined below.
    (Required) `name` - A name of the global session policy rule.
    (Optional) `priority` - A priority of the global session policy rule. To avoid an endless diff situation an error is thrown if an invalid property is provided. The Okta API defaults to the last (lowest) if not provided.
    (Optional) `enabled` - Whether to enable global session policy rule. Defaults to `true`.
    (Optional) `condition` - A condition of the global session policy rule. `condition` block as defined below.
      (Optional) `excluded_users` - A set of user IDs to exclude.
      (Optional) `network` - A configuration for network condition. `network` block as defined below.
        (Optional) `excluded_zones` - A set of zone IDs to exclude.
        (Optional) `included_zones` - A set of zone IDs to include.
      (Optional) `authentication` - A configuration for authentication condition. `authentication` block as defined below.
        (Optional) `entrypoint` - The entry point for the authentication. Valid values are `ANY`, `LDAP_INTERFACE`, or `RADIUS`. Defaults to `ANY`.
        (Optional) `identity_provider` - The identity provider for the authentication. Valid values are `ANY`, `OKTA`, or `SPECIFIC_IDP`. Defaults to `ANY`. WARNING: Use of identity_provider requires a feature flag to be enabled.
    (Optional) `allow_access` - Whether to allow access. Defaults to `true`.
    (Optional) `primary_factor` - The primary authentication factor. Only works for the Okta Identity Engine. Valid values are `PASSWORD_IDP` or `PASSWORD_IDP_ANY_FACTOR`. Defaults to `PASSWORD_IDP_ANY_FACTOR`.
      `PASSWORD_IDP`: Users must always use a password to establish a session.
      `PASSWORD_IDP_ANY_FACTOR`: Users can use any factor required by the app authentication policy to establish a session.
    (Optional) `mfa` - A configuration for multi-factor authentication. `mfa` block as defined below.
      (Optional) `required` - Whether to require multi-factor authentication. Defaults to `false`.
      (Optional) `prompt_mode` - Indicates if the user should be challenged for a MFA based on the device being used, a factor session lifetime, or on every sign-in attempt. Valid values are `ALWAYS`, `SESSION`, or `DEVICE`. Defaults to `ALWAYS`.
      (Optional) `session_duration` - Interval of time that must elapse before the user is challenged for MFA, if the value of `prompt_mode` is set to `SESSION`. Defaults to `15` minutes.
      (Optional) `remember_device_by_default` - Whether Okta should automatically remember the device. Defaults to `false`.
    (Optional) `session` - A configuration for session of the global session policy rule. `session` block as defined below.
      (Optional) `duration` - Max minutes a session is active. Setting a maximum session lifetime reduces the risk of session cookie misuse or hijacking. The value of `0` means unlimited. Defaults to `720` (12 hours).
      (Optional) `idle_timeout` - Max minutes a seesion can be idle. A global session will expire when the user is inactive for the specified amount of time, regardless of the maximum global session lifetime. Defaults to `120` (2 hours).
      (Optional) `persistent_cookie_enabled` - Whether to enable persistent cookie. If enabled, when a user reopens their browser, and their session is still active, they won’t be asked to sign in again. Defaults to `false`.
  EOF
  type = list(object({
    name     = string
    priority = optional(number)
    enabled  = optional(bool, true)

    condition = optional(object({
      excluded_users = optional(set(string), [])
      network = optional(object({
        excluded_zones = optional(set(string), [])
        included_zones = optional(set(string), [])
      }), {})
      authentication = optional(object({
        entrypoint        = optional(string, "ANY")
        identity_provider = optional(string, "ANY")
      }), {})
    }), {})

    allow_access   = optional(bool, true)
    primary_factor = optional(string, "PASSWORD_IDP_ANY_FACTOR")
    mfa = optional(object({
      required                   = optional(bool, false)
      prompt_mode                = optional(string, "ALWAYS")
      session_duration           = optional(number, 15)
      remember_device_by_default = optional(bool, false)
    }), {})
    session = optional(object({
      duration                  = optional(number, 60 * 12)
      idle_timeout              = optional(number, 60 * 2)
      persistent_cookie_enabled = optional(bool, false)
    }), {})
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["ANY", "LDAP_INTERFACE", "RADIUS"], rule.condition.authentication.entrypoint)
    ])
    error_message = "Valid values for `authentication.entrypoint` must be one of `ANY`, `LDAP_INTERFACE`, or `RADIUS`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["ANY", "OKTA", "SPECIFIC_IDP"], rule.condition.authentication.identity_provider)
    ])
    error_message = "Valid values for `authentication.identity_provider` must be one of `ANY`, `OKTA`, or `SPECIFIC_IDP`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["PASSWORD_IDP_ANY_FACTOR", "PASSWORD_IDP"], rule.primary_factor)
    ])
    error_message = "Valid values for `primary_factor` must be one of `PASSWORD_IDP_ANY_FACTOR` or `PASSWORD_IDP`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["ALWAYS", "SESSION", "DEVICE"], rule.mfa.prompt_mode)
    ])
    error_message = "Valid values for `mfa.prompt_mode` must be one of `ALWAYS`, `SESSION`, or `DEVICE`."
  }
}
