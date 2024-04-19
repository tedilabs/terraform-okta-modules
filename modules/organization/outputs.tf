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
