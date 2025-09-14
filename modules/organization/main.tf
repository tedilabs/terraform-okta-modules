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

locals {
  country_codes = {
    "KR" = "Korea, Republic of"
  }
}

###################################################
# Organization Configuration
###################################################

# TODO: `billing_contact_user`
# TODO: `technical_contact_user`
resource "okta_org_configuration" "this" {
  company_name                 = var.name
  logo                         = var.logo
  opt_out_communication_emails = !var.communication_emails_enabled


  ## Contact
  country     = try(local.country_codes[var.contact.country_code], null)
  state       = var.contact.state
  city        = var.contact.city
  address_1   = var.contact.address_line_1
  address_2   = var.contact.address_line_2
  postal_code = var.contact.postal_code

  phone_number = var.contact.phone
  website      = var.contact.website_url


  ## End-user Support
  support_phone_number      = var.end_user_support.phone
  end_user_support_help_url = var.end_user_support.url
}


###################################################
# Rate Limiting Preferences
###################################################

# INFO: This resource is deprecated and will be removed in a future release. A new resource to manage rate limiting settings will be implemented in the future.
# resource "okta_rate_limiting" "this" {
#   login     = var.rate_limiting_preferences.on_login
#   authorize = var.rate_limiting_preferences.on_authorize
#
#   communications_enabled = var.rate_limiting_preferences.warning_notification_email_enabled
# }


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
