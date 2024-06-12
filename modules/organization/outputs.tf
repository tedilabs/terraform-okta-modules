output "id" {
  description = "The ID of the Okta organization."
  value       = okta_org_configuration.this.id
}

output "name" {
  description = "The name of the Okta organization."
  value       = okta_org_configuration.this.company_name
}

output "logo" {
  description = "The logo file of the Okta organization."
  value       = okta_org_configuration.this.logo
}

output "slug" {
  description = "The slug of the Okta organization which is used for the sub-domain like `{slug}.okta.com`."
  value       = okta_org_configuration.this.subdomain
}

output "communication_emails_enabled" {
  description = "Whether to enable communication emails."
  value       = !okta_org_configuration.this.opt_out_communication_emails
}

output "contact" {
  description = "The contact attached to the Okta organization."
  value = {
    country_code   = var.contact.country_code
    country        = okta_org_configuration.this.country
    state          = okta_org_configuration.this.state
    city           = okta_org_configuration.this.city
    address_line_1 = okta_org_configuration.this.address_1
    address_line_2 = okta_org_configuration.this.address_2
    postal_code    = okta_org_configuration.this.postal_code
    phone          = okta_org_configuration.this.phone_number
    website_url    = okta_org_configuration.this.website
  }
}

output "end_user_support" {
  description = "The information for the end-user support."
  value = {
    phone = okta_org_configuration.this.support_phone_number
    url   = okta_org_configuration.this.end_user_support_help_url
  }
}

output "expire_at" {
  description = "The datetime which this organization expires."
  value       = okta_org_configuration.this.expires_at
}

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

# output "debug" {
#   value = {
#     for k, v in okta_org_configuration.this :
#     k => v
#     if !contains(["id", "company_name", "subdomain", "country", "state", "city", "address_1", "address_2", "postal_code", "phone_number", "website", "expires_at", "support_phone_number", "end_user_support_help_url", "opt_out_communication_emails", "logo"], k)
#   }
# }
