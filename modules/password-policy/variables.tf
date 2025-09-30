variable "name" {
  description = "(Required) A name of the Okta Password Policy. Use `default` to manage the default password policy."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) A description of the Okta Password Policy. Only used when `name` is not `default`."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "enabled" {
  description = "(Optional) Whether to enable the Okta Password Policy. Defaults to `true`. Only used when `name` is not `default`."
  type        = bool
  default     = true
  nullable    = false
}

variable "authentication_provider" {
  description = "(Optional) The authentication provider which the Okta Password Policy applies to. Valid values are `OKTA`, `LDAP`, `ACTIVE_DIRECTORY`. Defaults to `OKTA`."
  type        = string
  default     = "OKTA"
  nullable    = false

  validation {
    condition     = contains(["OKTA", "LDAP", "ACTIVE_DIRECTORY"], var.authentication_provider)
    error_message = "Valid values are `OKTA`, `LDAP`, `ACTIVE_DIRECTORY`."
  }
}

variable "priority" {
  description = "(Optional) A priority of the Okta Password Policy. Only used when `name` is not `default`."
  type        = number
  default     = null
  nullable    = true
}

variable "groups" {
  description = "(Optional) A set of group IDs to assign the Okta Password Policy to."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition = anytrue([
      var.name == "default",
      var.name != "default" && length(var.groups) > 0,
    ])
    error_message = "At least one group ID must be assigned to the Okta Password Policy when the policy is not default."
  }
}

variable "complexity" {
  description = <<EOF
  (Optional) A configuration for password complexity requirements of the Okta Password Policy. `complexity` block as defined below.
    (Optional) `min_length` - Minimum password length. Defaults to `8`.
    (Optional) `lowercase_required` - If a password must contain at least one lower case letter. Defaults to `true`.
    (Optional) `uppercase_required` - If a password must contain at least one upper case letter. Defaults to `true`.
    (Optional) `number_required` - If a password must contain at least one number. Defaults to `true`.
    (Optional) `symbol_required` - If a password must contain at least one symbol (!@#$%^&*). Defaults to `false`.
    (Optional) `first_name_restricted` - If a password must not contain the user's first name. Defaults to `false`.
    (Optional) `last_name_restricted` - If a password must not contain the user's last name. Defaults to `false`.
    (Optional) `username_restricted` - If a password must not contain the user's username. Defaults to `true`.
    (Optional) `common_password_restricted` - Whether to restrict passwords against common password dictionary. Defaults to `true`.
    (Optional) `reuse_restriction_count` - The number of distinct passwords that must be created before they can be reused. The value of `0` means no restriction. Defaults to `0`.
  EOF
  type = object({
    min_length = optional(number, 8)

    lowercase_required = optional(bool, true)
    uppercase_required = optional(bool, true)
    number_required    = optional(bool, true)
    symbol_required    = optional(bool, false)

    first_name_restricted      = optional(bool, false)
    last_name_restricted       = optional(bool, false)
    username_restricted        = optional(bool, true)
    common_password_restricted = optional(bool, true)

    reuse_restriction_count = optional(number, 0)
  })
  default  = {}
  nullable = false
}

variable "expiration" {
  description = <<EOF
  (Optional) A configuration for password expiration of the Okta Password Policy. `expiration` block as defined below.
    (Optional) `max_age_days` - The number of days before a password expires. The value of `0` means no expiration. Defaults to `0`.
    (Optional) `min_age_minutes` - The minimum number of minutes that must pass before a password can be changed. The value of `0` means no limit. Defaults to `0
    (Optional) `remind_before_days` - The number of days before a password expires to remind the user. The value of `0` means no reminder. Defaults to `0`.
  EOF
  type = object({
    max_age_days       = optional(number, 0)
    min_age_minutes    = optional(number, 0)
    remind_before_days = optional(number, 0)
  })
  default  = {}
  nullable = false
}

variable "lockout" {
  description = <<EOF
  (Optional) A configuration for password lock-out of the Okta Password Policy. `lockout` block as defined below.
    (Optional) `max_attempts` - Maximum number of unsuccessful login attempts before a user is locked out. The value of `0` means no limit. Defaults to `10`.
    (Optional) `duration` - Number of minutes before a locked account is unlocked. The value of `0` means no limit. Defaults to `60`.
    (Optional) `show_failures` - Whether to inform a user when their account is locked. Defaults to `false`.
    (Optional) `notification_channels` - A set of notification channels to use to notify a user when their account has been locked. Valid values are `EMAIL`, `SMS`, `PUSH`. Defaults to `EMAIL`.
  EOF
  type = object({
    max_attempts          = optional(number, 10)
    duration              = optional(number, 60)
    show_failures         = optional(bool, false)
    notification_channels = optional(set(string), ["EMAIL"])
  })
  default  = {}
  nullable = false
}

variable "recovery" {
  description = <<EOF
  (Optional) A configuration for password recovery of the Okta Password Policy. `recovery` block as defined below.
    (Optional) `call` - A configuration for password recovery call. `call` block as defined below.
      (Optional) `enabled` - Whether to enable password recovery call. Defaults to `false`.
    (Optional) `email` - A configuration for password recovery email. `email` block as defined below.
      (Optional) `enabled` - Whether to enable password recovery email. Defaults to `true`.
      (Optional) `token_ttl` - Lifetime in minutes of the recovery email token. Defaults to `60`.
    (Optional) `question` - A configuration for password recovery question. `question` block as defined below.
      (Optional) `enabled` - Whether to enable password recovery question. Defaults to `false`.
      (Optional) `min_answer_length` - Minimum length of the password recovery question answer. Defaults to `4`.
    (Optional) `sms` - A configuration for password recovery sms. `sms` block as defined below.
      (Optional) `enabled` - Whether to enable password recovery sms. Defaults to `false`.
  EOF
  type = object({
    call = optional(object({
      enabled = optional(bool, false)
    }), {})
    email = optional(object({
      enabled   = optional(bool, true)
      token_ttl = optional(number, 60)
    }), {})
    question = optional(object({
      enabled           = optional(bool, false)
      min_answer_length = optional(number, 4)
    }), {})
    sms = optional(object({
      enabled = optional(bool, false)
    }), {})
  })
  default  = {}
  nullable = false
}

variable "rules" {
  description = <<EOF
  (Optional) A configuration for rules of the Okta Password Policy. Each item of `rules` block as defined below.
    (Required) `name` - A name of the password policy rule.
    (Optional) `priority` - A priority of the password policy rule. To avoid an endless diff situation an error is thrown if an invalid property is provided. The Okta API defaults to the last (lowest) if not provided.
    (Optional) `enabled` - Whether to enable password policy rule. Defaults to `true`.
    (Optional) `condition` - A condition of the password policy rule. `condition` block as defined below.
      (Optional) `excluded_users` - A set of user IDs to exclude.
      (Optional) `network` - A configuration for network condition. `network` block as defined below.
        (Optional) `scope` - A network scope for network condition. Valid values are `ANYWHERE`, `ON_NETWORK`, `OFF_NETWORK` or `ZONE`. Defaults to `ANYWHERE`.
        (Optional) `excluded_zones` - A set of zone IDs to exclude. Only used when `scope` is `ZONE`.
        (Optional) `included_zones` - A set of zone IDs to include. Only used when `scope` is `ZONE`.
    (Optional) `allow_password_change` - Whether to allow users to change their password. Defaults to `true`.
    (Optional) `allow_password_reset` - Whether to allow users to reset their password. Defaults to `true`.
    (Optional) `allow_password_unlock` - Whether to allow users to unlock. Defaults to `false`.
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

    allow_password_change = optional(bool, true)
    allow_password_reset  = optional(bool, true)
    allow_password_unlock = optional(bool, false)
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["ANYWHERE", "ON_NETWORK", "OFF_NETWORK", "ZONE"], rule.condition.network.scope)
    ])
    error_message = "Valid values for `scope` are `ANYWHERE`, `ON_NETWORK`, `OFF_NETWORK` or `ZONE`."
  }
}
