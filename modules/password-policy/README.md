# password-policy

This module creates following resources.

- `okta_policy_password` (optional)
- `okta_policy_password_default` (optional)
- `okta_policy_rule_password` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 6.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_okta"></a> [okta](#provider\_okta) | 6.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [okta_policy_password.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/policy_password) | resource |
| [okta_policy_password_default.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/policy_password_default) | resource |
| [okta_policy_rule_password.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/policy_rule_password) | resource |
| [okta_group.this](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) A name of the Okta Password Policy. Use `default` to manage the default password policy. | `string` | n/a | yes |
| <a name="input_authentication_provider"></a> [authentication\_provider](#input\_authentication\_provider) | (Optional) The authentication provider which the Okta Password Policy applies to. Valid values are `OKTA`, `LDAP`, `ACTIVE_DIRECTORY`. Defaults to `OKTA`. | `string` | `"OKTA"` | no |
| <a name="input_complexity"></a> [complexity](#input\_complexity) | (Optional) A configuration for password complexity requirements of the Okta Password Policy. `complexity` block as defined below.<br/>    (Optional) `min_length` - Minimum password length. Defaults to `8`.<br/>    (Optional) `lowercase_required` - If a password must contain at least one lower case letter. Defaults to `true`.<br/>    (Optional) `uppercase_required` - If a password must contain at least one upper case letter. Defaults to `true`.<br/>    (Optional) `number_required` - If a password must contain at least one number. Defaults to `true`.<br/>    (Optional) `symbol_required` - If a password must contain at least one symbol (!@#$%^&*). Defaults to `false`.<br/>    (Optional) `first_name_restricted` - If a password must not contain the user's first name. Defaults to `false`.<br/>    (Optional) `last_name_restricted` - If a password must not contain the user's last name. Defaults to `false`.<br/>    (Optional) `username_restricted` - If a password must not contain the user's username. Defaults to `true`.<br/>    (Optional) `common_password_restricted` - Whether to restrict passwords against common password dictionary. Defaults to `true`.<br/>    (Optional) `reuse_restriction_count` - The number of distinct passwords that must be created before they can be reused. The value of `0` means no restriction. Defaults to `0`. | <pre>object({<br/>    min_length = optional(number, 8)<br/><br/>    lowercase_required = optional(bool, true)<br/>    uppercase_required = optional(bool, true)<br/>    number_required    = optional(bool, true)<br/>    symbol_required    = optional(bool, false)<br/><br/>    first_name_restricted      = optional(bool, false)<br/>    last_name_restricted       = optional(bool, false)<br/>    username_restricted        = optional(bool, true)<br/>    common_password_restricted = optional(bool, true)<br/><br/>    reuse_restriction_count = optional(number, 0)<br/>  })</pre> | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the Okta Password Policy. Only used when `name` is not `default`. | `string` | `"Managed by Terraform."` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether to enable the Okta Password Policy. Defaults to `true`. Only used when `name` is not `default`. | `bool` | `true` | no |
| <a name="input_expiration"></a> [expiration](#input\_expiration) | (Optional) A configuration for password expiration of the Okta Password Policy. `expiration` block as defined below.<br/>    (Optional) `max_age_days` - The number of days before a password expires. The value of `0` means no expiration. Defaults to `0`.<br/>    (Optional) `min_age_minutes` - The minimum number of minutes that must pass before a password can be changed. The value of `0` means no limit. Defaults to `0<br/>    (Optional) `remind\_before\_days` - The number of days before a password expires to remind the user. The value of `0` means no reminder. Defaults to `0`.<br/>` | <pre>object({<br/>    max_age_days       = optional(number, 0)<br/>    min_age_minutes    = optional(number, 0)<br/>    remind_before_days = optional(number, 0)<br/>  })</pre> | `{}` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | (Optional) A set of group IDs to assign the Okta Password Policy to. | `set(string)` | `[]` | no |
| <a name="input_lockout"></a> [lockout](#input\_lockout) | (Optional) A configuration for password lock-out of the Okta Password Policy. `lockout` block as defined below.<br/>    (Optional) `max_attempts` - Maximum number of unsuccessful login attempts before a user is locked out. The value of `0` means no limit. Defaults to `10`.<br/>    (Optional) `duration` - Number of minutes before a locked account is unlocked. The value of `0` means no limit. Defaults to `60`.<br/>    (Optional) `show_failures` - Whether to inform a user when their account is locked. Defaults to `false`.<br/>    (Optional) `notification_channels` - A set of notification channels to use to notify a user when their account has been locked. Valid values are `EMAIL`, `SMS`, `PUSH`. Defaults to `EMAIL`. | <pre>object({<br/>    max_attempts          = optional(number, 10)<br/>    duration              = optional(number, 60)<br/>    show_failures         = optional(bool, false)<br/>    notification_channels = optional(set(string), ["EMAIL"])<br/>  })</pre> | `{}` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | (Optional) A priority of the Okta Password Policy. Only used when `name` is not `default`. | `number` | `null` | no |
| <a name="input_recovery"></a> [recovery](#input\_recovery) | (Optional) A configuration for password recovery of the Okta Password Policy. `recovery` block as defined below.<br/>    (Optional) `call` - A configuration for password recovery call. `call` block as defined below.<br/>      (Optional) `enabled` - Whether to enable password recovery call. Defaults to `false`.<br/>    (Optional) `email` - A configuration for password recovery email. `email` block as defined below.<br/>      (Optional) `enabled` - Whether to enable password recovery email. Defaults to `true`.<br/>      (Optional) `token_ttl` - Lifetime in minutes of the recovery email token. Defaults to `60`.<br/>    (Optional) `question` - A configuration for password recovery question. `question` block as defined below.<br/>      (Optional) `enabled` - Whether to enable password recovery question. Defaults to `false`.<br/>      (Optional) `min_answer_length` - Minimum length of the password recovery question answer. Defaults to `4`.<br/>    (Optional) `sms` - A configuration for password recovery sms. `sms` block as defined below.<br/>      (Optional) `enabled` - Whether to enable password recovery sms. Defaults to `false`. | <pre>object({<br/>    call = optional(object({<br/>      enabled = optional(bool, false)<br/>    }), {})<br/>    email = optional(object({<br/>      enabled   = optional(bool, true)<br/>      token_ttl = optional(number, 60)<br/>    }), {})<br/>    question = optional(object({<br/>      enabled           = optional(bool, false)<br/>      min_answer_length = optional(number, 4)<br/>    }), {})<br/>    sms = optional(object({<br/>      enabled = optional(bool, false)<br/>    }), {})<br/>  })</pre> | `{}` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | (Optional) A configuration for rules of the Okta Password Policy. Each item of `rules` block as defined below.<br/>    (Required) `name` - A name of the password policy rule.<br/>    (Optional) `priority` - A priority of the password policy rule. To avoid an endless diff situation an error is thrown if an invalid property is provided. The Okta API defaults to the last (lowest) if not provided.<br/>    (Optional) `enabled` - Whether to enable password policy rule. Defaults to `true`.<br/>    (Optional) `condition` - A condition of the password policy rule. `condition` block as defined below.<br/>      (Optional) `excluded_users` - A set of user IDs to exclude.<br/>      (Optional) `network` - A configuration for network condition. `network` block as defined below.<br/>        (Optional) `scope` - A network scope for network condition. Valid values are `ANYWHERE`, `ON_NETWORK`, `OFF_NETWORK` or `ZONE`. Defaults to `ANYWHERE`.<br/>        (Optional) `excluded_zones` - A set of zone IDs to exclude. Only used when `scope` is `ZONE`.<br/>        (Optional) `included_zones` - A set of zone IDs to include. Only used when `scope` is `ZONE`.<br/>    (Optional) `allow_password_change` - Whether to allow users to change their password. Defaults to `true`.<br/>    (Optional) `allow_password_reset` - Whether to allow users to reset their password. Defaults to `true`.<br/>    (Optional) `allow_password_unlock` - Whether to allow users to unlock. Defaults to `false`. | <pre>list(object({<br/>    name     = string<br/>    priority = optional(number)<br/>    enabled  = optional(bool, true)<br/><br/>    condition = optional(object({<br/>      excluded_users = optional(set(string), [])<br/>      network = optional(object({<br/>        scope          = optional(string, "ANYWHERE")<br/>        excluded_zones = optional(set(string), [])<br/>        included_zones = optional(set(string), [])<br/>      }), {})<br/>    }), {})<br/><br/>    allow_password_change = optional(bool, true)<br/>    allow_password_reset  = optional(bool, true)<br/>    allow_password_unlock = optional(bool, false)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_authentication_provider"></a> [authentication\_provider](#output\_authentication\_provider) | The authentication provider which the Okta Password Policy applies to. |
| <a name="output_complexity"></a> [complexity](#output\_complexity) | The complexity requirements of the Okta Password Policy. |
| <a name="output_description"></a> [description](#output\_description) | The description of the Okta Password Policy. |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether the Okta Password Policy is enabled. |
| <a name="output_expiration"></a> [expiration](#output\_expiration) | The configuration for password expiration of the Okta Password Policy. |
| <a name="output_groups"></a> [groups](#output\_groups) | The information for the assigned groups of the Okta Password Policy. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Okta Password Policy. |
| <a name="output_lockout"></a> [lockout](#output\_lockout) | The configuration for password lock-out of the Okta Password Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Okta Password Policy. |
| <a name="output_priority"></a> [priority](#output\_priority) | The priority of the Okta Password Policy. |
| <a name="output_recovery"></a> [recovery](#output\_recovery) | The configuration for password recovery of the Okta Password Policy. |
| <a name="output_rules"></a> [rules](#output\_rules) | The configuration for rules of the Okta Password Policy. |
<!-- END_TF_DOCS -->
