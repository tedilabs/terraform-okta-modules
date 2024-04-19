# organization

This module creates following resources.

- `okta_security_notification_emails`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
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
| [okta_security_notification_emails.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/security_notification_emails) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_security_notification_email_preferences"></a> [security\_notification\_email\_preferences](#input\_security\_notification\_email\_preferences) | (Optional) A preferences for security notification emails. `security_notification_email_preferences` block as defined below.<br>    (Optional) `report_on_suspicious_activity` - Whether to notify end users about suspicious<br>    or unrecognized activity from their account. Defaults to `true`.<br>    (Optional) `notify_on_factor_enrollment` - Whether to notify end users of any activity on their account related to MFA factor enrollment. Defaults to `true`.<br>    (Optional) `notify_on_factor_reset` - Whether to notify end users that one or more factors have been reset for their account. Defaults to `true`.<br>    (Optional) `notify_on_new_device` - Whether to notify end users about new sign-on activity. Defaults to `false`.<br>    (Optional) `notify_on_password_changed` - Whether to notify end users that the password for their account has changed. Defaults to `true`. | <pre>object({<br>    report_on_suspicious_activity = optional(bool, true)<br>    notify_on_factor_enrollment   = optional(bool, true)<br>    notify_on_factor_reset        = optional(bool, true)<br>    notify_on_new_device          = optional(bool, false)<br>    notify_on_password_changed    = optional(bool, true)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_notification_email_preferences"></a> [security\_notification\_email\_preferences](#output\_security\_notification\_email\_preferences) | The preferences for security notification emails. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
