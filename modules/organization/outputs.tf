output "rate_limiting_preferences" {
  description = "The preferences for rate limiting."
  value = {
    on_login     = okta_rate_limiting.this.login
    on_authorize = okta_rate_limiting.this.authorize

    warning_notification_email_enabled = okta_rate_limiting.this.communications_enabled
  }
}

output "security_notification_email_preferences" {
  description = "The preferences for security notification emails."
  value = {
    report_on_suspicious_activity = okta_security_notification_emails.this.report_suspicious_activity_enabled
    notify_on_factor_enrollment   = okta_security_notification_emails.this.send_email_for_factor_enrollment_enabled
    notify_on_factor_reset        = okta_security_notification_emails.this.send_email_for_factor_reset_enabled
    notify_on_new_device          = okta_security_notification_emails.this.send_email_for_new_device_enabled
    notify_on_password_changed    = okta_security_notification_emails.this.send_email_for_password_changed_enabled
  }
}
