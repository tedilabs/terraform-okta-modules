variable "name" {
  description = "(Required) A name of the organization."
  type        = string
  nullable    = false
}

variable "logo" {
  description = "(Optional) The organization logo image. The file must be in PNG, JPG, or GIF format and less than 1 MB in size. For best results use landscape orientation, a transparent background, and a minimum size of 420px by 120px to prevent upscaling."
  type        = string
  default     = null
  nullable    = true
}

variable "communication_emails_enabled" {
  description = "(Optional) Whether the organization's users receive Okta Communication emails. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "contact" {
  description = <<EOF
  (Optional) The configuration of the contact for the Okta organization. `contact` as defined below.
    (Optional) `country_code` - The ISO-3166 two-letter country code for the contact address.
    (Optional) `state` - The state or region of the contact address. This field is required in selected countries.
    (Optional) `city` - The city of the contact address.
    (Optional) `district` - The district or county of the contact address, if any.
    (Optional) `address_line_1` - The first line of the contact address.
    (Optional) `address_line_2` - The second line of the contact address, if any.
    (Optional) `postal_code` - The postal code of the contact address.
    (Optional) `phone` - The phone number of the contact information.
    (Optional) `website_url` - The URL of the website associated with the contact information, if any.
  EOF
  type = object({
    country_code   = optional(string)
    state          = optional(string)
    city           = optional(string)
    district       = optional(string)
    address_line_1 = optional(string)
    address_line_2 = optional(string)
    postal_code    = optional(string)
    phone          = optional(string)
    website_url    = optional(string)
  })
  nullable = true
  default  = null
}

variable "end_user_support" {
  description = <<EOF
  (Optional) The configuration of the contact for the end-user support. `end_user_support` as defined below.
    (Optional) `phone` - The phone number of the end-user support contact.
    (Optional) `url` - The URL of the website associated with the end-user support contact. If provided, end-users who click the "Help" link in the footer of Okta will be directed to this URL, rather than the technical contact's email address.
  EOF
  type = object({
    phone = optional(string)
    url   = optional(string)
  })
  nullable = true
  default  = null
}

# variable "rate_limiting_preferences" {
#   description = <<EOF
#   (Optional) A preferences for rate limiting. `rate_limiting_preferences` block as defined below.
#     (Optional) `on_login` - Prevent individual clients from blocking traffic when accessing the Okta hosted login page. Valid values are `ENFORCE` (Enforce limit and log per client (recommended)), `DISABLE` (Do nothing (not recommended)), `PREVIEW` (Log per client). Defaults to `ENFORCE`.
#     (Optional) `on_authorize` - Prevent individual clients from blocking traffic during authorization. Valid values are `ENFORCE` (Enforce limit and log per client (recommended)), `DISABLE` (Do nothing (not recommended)), `PREVIEW` (Log per client). Defaults to `ENFORCE`.
#     (Optional) `warning_notification_email_enabled` - Whether to enable rate limit warning and violation notification emails when this org meets rate limits. Defaults to `true`.
#   EOF
#   type = object({
#     on_login     = optional(string, "ENFORCE")
#     on_authorize = optional(string, "ENFORCE")
#
#     warning_notification_email_enabled = optional(bool, true)
#   })
#   default  = {}
#   nullable = false
#
#   validation {
#     condition = alltrue([
#       contains(["ENFORCE", "PREVIEW", "DISABLE"], var.rate_limiting_preferences.on_login),
#       contains(["ENFORCE", "PREVIEW", "DISABLE"], var.rate_limiting_preferences.on_authorize),
#     ])
#     error_message = "Valid values for `on_lgin` and `on_authorize` are `ENFORCE`, `PREVIEW`, or `DISABLE`."
#   }
# }

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
