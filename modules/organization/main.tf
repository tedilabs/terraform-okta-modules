# locals {
#   metadata = {
#     package = "terraform-okta-modules"
#     version = trimspace(file("${path.module}/../../VERSION"))
#     module  = basename(path.module)
#     name    = var.name
#   }
#   module_tags = {
#     "module.terraform.io/package"   = local.metadata.package
#     "module.terraform.io/version"   = local.metadata.version
#     "module.terraform.io/name"      = local.metadata.module
#     "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
#     "module.terraform.io/instance"  = local.metadata.name
#   }
# }


###################################################
# Rate Limiting Preferences
###################################################

resource "okta_rate_limiting" "this" {
  login     = var.rate_limiting_preferences.on_login
  authorize = var.rate_limiting_preferences.on_authorize

  communications_enabled = var.rate_limiting_preferences.warning_notification_email_enabled
}


###################################################
# Security Notification Preferences for Organization
###################################################

resource "okta_security_notification_emails" "this" {
  report_suspicious_activity_enabled = var.security_notification_email_preferences.report_on_suspicious_activity

  send_email_for_factor_enrollment_enabled = var.security_notification_email_preferences.notify_on_factor_enrollment
  send_email_for_factor_reset_enabled      = var.security_notification_email_preferences.notify_on_factor_reset
  send_email_for_new_device_enabled        = var.security_notification_email_preferences.notify_on_new_device
  send_email_for_password_changed_enabled  = var.security_notification_email_preferences.notify_on_password_changed
}
