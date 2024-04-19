# variable "name" {
#   description = "(Required) A name of the organization."
#   type        = string
#   nullable    = false
# }

variable "rate_limiting_preferences" {
  description = <<EOF
  (Optional) A preferences for rate limiting. `rate_limiting_preferences` block as defined below.
    (Optional) `on_login` - Prevent individual clients from blocking traffic when accessing the Okta hosted login page. Valid values are `ENFORCE` (Enforce limit and log per client (recommended)), `DISABLE` (Do nothing (not recommended)), `PREVIEW` (Log per client). Defaults to `ENFORCE`.
    (Optional) `on_authorize` - Prevent individual clients from blocking traffic during authorization. Valid values are `ENFORCE` (Enforce limit and log per client (recommended)), `DISABLE` (Do nothing (not recommended)), `PREVIEW` (Log per client). Defaults to `ENFORCE`.
    (Optional) `warning_notification_email_enabled` - Whether to enable rate limit warning and violation notification emails when this org meets rate limits. Defaults to `true`.
  EOF
  type = object({
    on_login     = optional(string, "ENFORCE")
    on_authorize = optional(string, "ENFORCE")

    warning_notification_email_enabled = optional(bool, true)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      contains(["ENFORCE", "PREVIEW", "DISABLE"], var.rate_limiting_preferences.on_login),
      contains(["ENFORCE", "PREVIEW", "DISABLE"], var.rate_limiting_preferences.on_authorize),
    ])
    error_message = "Valid values for `on_lgin` and `on_authorize` are `ENFORCE`, `PREVIEW`, or `DISABLE`."
  }
}

variable "security_notification_email_preferences" {
  description = <<EOF
  (Optional) A preferences for security notification emails. `security_notification_email_preferences` block as defined below.
    (Optional) `report_on_suspicious_activity` - Whether to notify end users about suspicious or unrecognized activity from their account. Defaults to `true`.
    (Optional) `notify_on_factor_enrollment` - Whether to notify end users of any activity on their account related to MFA factor enrollment. Defaults to `true`.
    (Optional) `notify_on_factor_reset` - Whether to notify end users that one or more factors have been reset for their account. Defaults to `true`.
    (Optional) `notify_on_new_device` - Whether to notify end users about new sign-on activity. Defaults to `false`.
    (Optional) `notify_on_password_changed` - Whether to notify end users that the password for their account has changed. Defaults to `true`.
  EOF
  type = object({
    report_on_suspicious_activity = optional(bool, true)
    notify_on_factor_enrollment   = optional(bool, true)
    notify_on_factor_reset        = optional(bool, true)
    notify_on_new_device          = optional(bool, false)
    notify_on_password_changed    = optional(bool, true)
  })
  default  = {}
  nullable = false
}
