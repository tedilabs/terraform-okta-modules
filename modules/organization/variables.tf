# variable "name" {
#   description = "(Required) A name of the organization."
#   type        = string
#   nullable    = false
# }

variable "security_notification_email_preferences" {
  description = <<EOF
  (Optional) A preferences for security notification emails. `security_notification_email_preferences` block as defined below.
    (Optional) `report_on_suspicious_activity` - Whether to notify end users about suspicious
    or unrecognized activity from their account. Defaults to `true`.
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
