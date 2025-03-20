# organization

This module creates following resources.

- `okta_org_configuration`
- `okta_rate_limiting`
- `okta_security_notification_emails`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 4.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_okta"></a> [okta](#provider\_okta) | 4.8.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [okta_org_configuration.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/org_configuration) | resource |
| [okta_rate_limiting.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/rate_limiting) | resource |
| [okta_security_notification_emails.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/security_notification_emails) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) A name of the organization. | `string` | n/a | yes |
| <a name="input_communication_emails_enabled"></a> [communication\_emails\_enabled](#input\_communication\_emails\_enabled) | (Optional) Whether the organization's users receive Okta Communication emails. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_contact"></a> [contact](#input\_contact) | (Optional) The configuration of the contact for the Okta organization. `contact` as defined below.<br>    (Optional) `country_code` - The ISO-3166 two-letter country code for the contact address.<br>    (Optional) `state` - The state or region of the contact address. This field is required in selected countries.<br>    (Optional) `city` - The city of the contact address.<br>    (Optional) `district` - The district or county of the contact address, if any.<br>    (Optional) `address_line_1` - The first line of the contact address.<br>    (Optional) `address_line_2` - The second line of the contact address, if any.<br>    (Optional) `postal_code` - The postal code of the contact address.<br>    (Optional) `phone` - The phone number of the contact information.<br>    (Optional) `website_url` - The URL of the website associated with the contact information, if any. | <pre>object({<br>    country_code   = optional(string)<br>    state          = optional(string)<br>    city           = optional(string)<br>    district       = optional(string)<br>    address_line_1 = optional(string)<br>    address_line_2 = optional(string)<br>    postal_code    = optional(string)<br>    phone          = optional(string)<br>    website_url    = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_end_user_support"></a> [end\_user\_support](#input\_end\_user\_support) | (Optional) The configuration of the contact for the end-user support. `end_user_support` as defined below.<br>    (Optional) `phone` - The phone number of the end-user support contact.<br>    (Optional) `url` - The URL of the website associated with the end-user support contact. If provided, end-users who click the "Help" link in the footer of Okta will be directed to this URL, rather than the technical contact's email address. | <pre>object({<br>    phone = optional(string)<br>    url   = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_logo"></a> [logo](#input\_logo) | (Optional) The organization logo image. The file must be in PNG, JPG, or GIF format and less than 1 MB in size. For best results use landscape orientation, a transparent background, and a minimum size of 420px by 120px to prevent upscaling. | `string` | `null` | no |
| <a name="input_rate_limiting_preferences"></a> [rate\_limiting\_preferences](#input\_rate\_limiting\_preferences) | (Optional) A preferences for rate limiting. `rate_limiting_preferences` block as defined below.<br>    (Optional) `on_login` - Prevent individual clients from blocking traffic when accessing the Okta hosted login page. Valid values are `ENFORCE` (Enforce limit and log per client (recommended)), `DISABLE` (Do nothing (not recommended)), `PREVIEW` (Log per client). Defaults to `ENFORCE`.<br>    (Optional) `on_authorize` - Prevent individual clients from blocking traffic during authorization. Valid values are `ENFORCE` (Enforce limit and log per client (recommended)), `DISABLE` (Do nothing (not recommended)), `PREVIEW` (Log per client). Defaults to `ENFORCE`.<br>    (Optional) `warning_notification_email_enabled` - Whether to enable rate limit warning and violation notification emails when this org meets rate limits. Defaults to `true`. | <pre>object({<br>    on_login     = optional(string, "ENFORCE")<br>    on_authorize = optional(string, "ENFORCE")<br><br>    warning_notification_email_enabled = optional(bool, true)<br>  })</pre> | `{}` | no |
| <a name="input_security_notification_email_preferences"></a> [security\_notification\_email\_preferences](#input\_security\_notification\_email\_preferences) | (Optional) A preferences for security notification emails. `security_notification_email_preferences` block as defined below.<br>    (Optional) `report_on_suspicious_activity` - Whether to notify end users about suspicious or unrecognized activity from their account. Defaults to `true`.<br>    (Optional) `notify_on_factor_enrollment` - Whether to notify end users of any activity on their account related to MFA factor enrollment. Defaults to `true`.<br>    (Optional) `notify_on_factor_reset` - Whether to notify end users that one or more factors have been reset for their account. Defaults to `true`.<br>    (Optional) `notify_on_new_device` - Whether to notify end users about new sign-on activity. Defaults to `false`.<br>    (Optional) `notify_on_password_changed` - Whether to notify end users that the password for their account has changed. Defaults to `true`. | <pre>object({<br>    report_on_suspicious_activity = optional(bool, true)<br>    notify_on_factor_enrollment   = optional(bool, true)<br>    notify_on_factor_reset        = optional(bool, true)<br>    notify_on_new_device          = optional(bool, false)<br>    notify_on_password_changed    = optional(bool, true)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_communication_emails_enabled"></a> [communication\_emails\_enabled](#output\_communication\_emails\_enabled) | Whether to enable communication emails. |
| <a name="output_contact"></a> [contact](#output\_contact) | The contact attached to the Okta organization. |
| <a name="output_end_user_support"></a> [end\_user\_support](#output\_end\_user\_support) | The information for the end-user support. |
| <a name="output_expire_at"></a> [expire\_at](#output\_expire\_at) | The datetime which this organization expires. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Okta organization. |
| <a name="output_logo"></a> [logo](#output\_logo) | The logo file of the Okta organization. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Okta organization. |
| <a name="output_rate_limiting_preferences"></a> [rate\_limiting\_preferences](#output\_rate\_limiting\_preferences) | The preferences for rate limiting. |
| <a name="output_security_notification_email_preferences"></a> [security\_notification\_email\_preferences](#output\_security\_notification\_email\_preferences) | The preferences for security notification emails. |
| <a name="output_slug"></a> [slug](#output\_slug) | The slug of the Okta organization which is used for the sub-domain like `{slug}.okta.com`. |
<!-- END_TF_DOCS -->
