variable "name" {
  description = "(Required) A name of the Okta Authenticator Enrollment Policy. Use `default` to manage the default password policy."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) A description of the Okta Authenticator Enrollment Policy. Only used when `name` is not `default`."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "enabled" {
  description = "(Optional) Whether to enable the Okta Authenticator Enrollment Policy. Defaults to `true`. Only used when `name` is not `default`."
  type        = bool
  default     = true
  nullable    = false
}

variable "priority" {
  description = "(Optional) A priority of the Okta Authenticator Enrollment Policy. Only used when `name` is not `default`."
  type        = number
  default     = null
  nullable    = true
}

variable "groups" {
  description = "(Optional) A set of group IDs to assign the Okta Authenticator Enrollment Policy to."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition = anytrue([
      var.name == "default",
      var.name != "default" && length(var.groups) > 0,
    ])
    error_message = "At least one group ID must be assigned to the Okta Authenticator Enrollment Policy when the policy is not default."
  }
}

variable "required_authenticators" {
  description = <<EOF
  (Optional) A set of authenticators that are required for the Okta Authenticator Enrollment Policy. Valid values are `CUSTOM_OTP`, `DUO`, `EXTERNAL_IDP`, `GOOGLE_OTP`, `OKTA_EMAIL`, `OKTA_PASSWORD`, `OKTA_VERIFY`, `ONPREM_MFA`, `PHONE_NUMBER`, `RSA_TOKEN`, `SECURITY_QUESTION`, or `WEBAUTHN`.
  EOF
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition = alltrue([
      for authenticator in var.required_authenticators :
      contains(["CUSTOM_OTP", "DUO", "EXTERNAL_IDP", "GOOGLE_OTP", "OKTA_EMAIL", "OKTA_PASSWORD", "OKTA_VERIFY", "ONPREM_MFA", "PHONE_NUMBER", "RSA_TOKEN", "SECURITY_QUESTION", "WEBAUTHN"], authenticator)
    ])
    error_message = "Valid values for `required_authenticators` are `CUSTOM_OTP`, `DUO`, `EXTERNAL_IDP`, `GOOGLE_OTP`, `OKTA_EMAIL`, `OKTA_PASSWORD`, `OKTA_VERIFY`, `ONPREM_MFA`, `PHONE_NUMBER`, `RSA_TOKEN`, `SECURITY_QUESTION`, or `WEBAUTHN`."
  }
}

variable "optional_authenticators" {
  description = <<EOF
  (Optional) A set of authenticators that are optional for the Okta Authenticator Enrollment Policy. Valid values are `CUSTOM_OTP`, `DUO`, `EXTERNAL_IDP`, `GOOGLE_OTP`, `OKTA_EMAIL`, `OKTA_PASSWORD`, `OKTA_VERIFY`, `ONPREM_MFA`, `PHONE_NUMBER`, `RSA_TOKEN`, `SECURITY_QUESTION`, or `WEBAUTHN`.
  EOF
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition = alltrue([
      for authenticator in var.optional_authenticators :
      contains(["CUSTOM_OTP", "DUO", "EXTERNAL_IDP", "GOOGLE_OTP", "OKTA_EMAIL", "OKTA_PASSWORD", "OKTA_VERIFY", "ONPREM_MFA", "PHONE_NUMBER", "RSA_TOKEN", "SECURITY_QUESTION", "WEBAUTHN"], authenticator)
    ])
    error_message = "Valid values for `required_authenticators` are `CUSTOM_OTP`, `DUO`, `EXTERNAL_IDP`, `GOOGLE_OTP`, `OKTA_EMAIL`, `OKTA_PASSWORD`, `OKTA_VERIFY`, `ONPREM_MFA`, `PHONE_NUMBER`, `RSA_TOKEN`, `SECURITY_QUESTION`, or `WEBAUTHN`."
  }
}

variable "rules" {
  description = <<EOF
  (Optional) A configuration for rules of the Okta Authenticator Enrollment Policy. Each item of `rules` block as defined below.
    (Required) `name` - A name of the authenticator enrollment policy rule.
    (Optional) `priority` - A priority of the authenticator enrollment policy rule. To avoid an endless diff situation an error is thrown if an invalid property is provided. The Okta API defaults to the last (lowest) if not provided.
    (Optional) `enabled` - Whether to enable authenticator enrollment policy rule. Defaults to `true`.
    (Optional) `condition` - A condition of the authenticator enrollment policy rule. `condition` block as defined below.
      (Optional) `excluded_users` - A set of user IDs to exclude.
      (Optional) `network` - A configuration for network condition. `network` block as defined below.
        (Optional) `scope` - A network scope for network condition. Valid values are `ANYWHERE`, `ON_NETWORK`, `OFF_NETWORK` or `ZONE`. Defaults to `ANYWHERE`.
        (Optional) `excluded_zones` - A set of zone IDs to exclude. Only used when `scope` is `ZONE`.
        (Optional) `included_zones` - A set of zone IDs to include. Only used when `scope` is `ZONE`.
    (Required) `enroll` - When a user should be prompted for MFA. Valid values are `CHALLENGE`, `LOGIN`, or `NEVER`.
      `CHALLENGE` - Users will be prompted to enroll when they attempt to authenticate using a factor that requires MFA.
      `LOGIN` - Users will be prompted to enroll when they sign in.
      `NEVER` - Users should manually enroll from their settings page.
  EOF
  type = list(object({
    name     = string
    priority = optional(number)
    enabled  = optional(bool, true)

    condition = optional(object({
      excluded_users = optional(set(string), [])
      network = optional(object({
        scope          = optional(string, "ANYWHERE")
        excluded_zones = optional(set(string), [])
        included_zones = optional(set(string), [])
      }), {})
    }), {})

    enroll = string
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["CHALLENGE", "LOGIN", "NEVER"], rule.enroll)
    ])
    error_message = "Valid values for `enroll` are `CHALLENGE`, `LOGIN`, or `NEVER`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["ANYWHERE", "ON_NETWORK", "OFF_NETWORK", "ZONE"], rule.condition.network.scope)
    ])
    error_message = "Valid values for `scope` are `ANYWHERE`, `ON_NETWORK`, `OFF_NETWORK` or `ZONE`."
  }
}
