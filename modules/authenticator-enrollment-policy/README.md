# authenticator-enrollment-policy

This module creates following resources.

- `okta_policy_mfa` (optional)
- `okta_policy_mfa_default` (optional)
- `okta_policy_rule_mfa` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 4.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_okta"></a> [okta](#provider\_okta) | 6.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [okta_policy_mfa.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/policy_mfa) | resource |
| [okta_policy_mfa_default.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/policy_mfa_default) | resource |
| [okta_policy_rule_mfa.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/policy_rule_mfa) | resource |
| [okta_group.this](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) A name of the Okta Authenticator Enrollment Policy. Use `default` to manage the default password policy. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the Okta Authenticator Enrollment Policy. Only used when `name` is not `default`. | `string` | `"Managed by Terraform."` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether to enable the Okta Authenticator Enrollment Policy. Defaults to `true`. Only used when `name` is not `default`. | `bool` | `true` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | (Optional) A set of group IDs to assign the Okta Authenticator Enrollment Policy to. | `set(string)` | `[]` | no |
| <a name="input_optional_authenticators"></a> [optional\_authenticators](#input\_optional\_authenticators) | (Optional) A set of authenticators that are optional for the Okta Authenticator Enrollment Policy. Valid values are `CUSTOM_OTP`, `DUO`, `EXTERNAL_IDP`, `GOOGLE_OTP`, `OKTA_EMAIL`, `OKTA_PASSWORD`, `OKTA_VERIFY`, `ONPREM_MFA`, `PHONE_NUMBER`, `RSA_TOKEN`, `SECURITY_QUESTION`, or `WEBAUTHN`. | `set(string)` | `[]` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | (Optional) A priority of the Okta Authenticator Enrollment Policy. Only used when `name` is not `default`. | `number` | `null` | no |
| <a name="input_required_authenticators"></a> [required\_authenticators](#input\_required\_authenticators) | (Optional) A set of authenticators that are required for the Okta Authenticator Enrollment Policy. Valid values are `CUSTOM_OTP`, `DUO`, `EXTERNAL_IDP`, `GOOGLE_OTP`, `OKTA_EMAIL`, `OKTA_PASSWORD`, `OKTA_VERIFY`, `ONPREM_MFA`, `PHONE_NUMBER`, `RSA_TOKEN`, `SECURITY_QUESTION`, or `WEBAUTHN`. | `set(string)` | `[]` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | (Optional) A configuration for rules of the Okta Authenticator Enrollment Policy. Each item of `rules` block as defined below.<br/>    (Required) `name` - A name of the authenticator enrollment policy rule.<br/>    (Optional) `priority` - A priority of the authenticator enrollment policy rule. To avoid an endless diff situation an error is thrown if an invalid property is provided. The Okta API defaults to the last (lowest) if not provided.<br/>    (Optional) `enabled` - Whether to enable authenticator enrollment policy rule. Defaults to `true`.<br/>    (Optional) `condition` - A condition of the authenticator enrollment policy rule. `condition` block as defined below.<br/>      (Optional) `excluded_users` - A set of user IDs to exclude.<br/>      (Optional) `network` - A configuration for network condition. `network` block as defined below.<br/>        (Optional) `scope` - A network scope for network condition. Valid values are `ANYWHERE`, `ON_NETWORK`, `OFF_NETWORK` or `ZONE`. Defaults to `ANYWHERE`.<br/>        (Optional) `excluded_zones` - A set of zone IDs to exclude. Only used when `scope` is `ZONE`.<br/>        (Optional) `included_zones` - A set of zone IDs to include. Only used when `scope` is `ZONE`.<br/>    (Required) `enroll` - When a user should be prompted for MFA. Valid values are `CHALLENGE`, `LOGIN`, or `NEVER`.<br/>      `CHALLENGE` - Users will be prompted to enroll when they attempt to authenticate using a factor that requires MFA.<br/>      `LOGIN` - Users will be prompted to enroll when they sign in.<br/>      `NEVER` - Users should manually enroll from their settings page. | <pre>list(object({<br/>    name     = string<br/>    priority = optional(number)<br/>    enabled  = optional(bool, true)<br/><br/>    condition = optional(object({<br/>      excluded_users = optional(set(string), [])<br/>      network = optional(object({<br/>        scope          = optional(string, "ANYWHERE")<br/>        excluded_zones = optional(set(string), [])<br/>        included_zones = optional(set(string), [])<br/>      }), {})<br/>    }), {})<br/><br/>    enroll = string<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_description"></a> [description](#output\_description) | The description of the Okta Authenticator Enrollment Policy. |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether the Okta Authenticator Enrollment Policy is enabled. |
| <a name="output_groups"></a> [groups](#output\_groups) | The information for the assigned groups of the Okta Authenticator Enrollment Policy. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Okta Authenticator Enrollment Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Okta Authenticator Enrollment Policy. |
| <a name="output_optional_authenticators"></a> [optional\_authenticators](#output\_optional\_authenticators) | The set of optional authenticators for the Okta Authenticator Enrollment Policy. |
| <a name="output_priority"></a> [priority](#output\_priority) | The priority of the Okta Authenticator Enrollment Policy. |
| <a name="output_required_authenticators"></a> [required\_authenticators](#output\_required\_authenticators) | The set of required authenticators for the Okta Authenticator Enrollment Policy. |
| <a name="output_rules"></a> [rules](#output\_rules) | The configuration for rules of the Okta Authenticator Enrollment Policy. |
<!-- END_TF_DOCS -->
