# global-session-policy

This module creates following resources.

- `okta_policy_signon`
- `okta_policy_rule_signon` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 4.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_okta"></a> [okta](#provider\_okta) | 6.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [okta_policy_rule_signon.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/policy_rule_signon) | resource |
| [okta_policy_signon.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/policy_signon) | resource |
| [okta_group.this](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) A name of the Okta Global Session Policy. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the Okta Global Session Policy. | `string` | `"Managed by Terraform."` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether to enable the Okta Global Session Policy. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | (Optional) A set of group IDs to assign the Okta Global Session Policy to. | `set(string)` | `[]` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | (Optional) A priority of the Okta Global Session Policy. | `number` | `null` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | (Optional) A configuration for rules of the Okta Global Session Policy. Each item of `rules` block as defined below.<br/>    (Required) `name` - A name of the global session policy rule.<br/>    (Optional) `priority` - A priority of the global session policy rule. To avoid an endless diff situation an error is thrown if an invalid property is provided. The Okta API defaults to the last (lowest) if not provided.<br/>    (Optional) `enabled` - Whether to enable global session policy rule. Defaults to `true`.<br/>    (Optional) `condition` - A condition of the global session policy rule. `condition` block as defined below.<br/>      (Optional) `excluded_users` - A set of user IDs to exclude.<br/>      (Optional) `network` - A configuration for network condition. `network` block as defined below.<br/>        (Optional) `scope` - A network scope for network condition. Valid values are `ANYWHERE`, `ON_NETWORK`, `OFF_NETWORK` or `ZONE`. Defaults to `ANYWHERE`.<br/>        (Optional) `excluded_zones` - A set of zone IDs to exclude. Only used when `scope` is `ZONE`.<br/>        (Optional) `included_zones` - A set of zone IDs to include. Only used when `scope` is `ZONE`.<br/>      (Optional) `authentication` - A configuration for authentication condition. `authentication` block as defined below.<br/>        (Optional) `entrypoint` - The entry point for the authentication. Valid values are `ANY`, `LDAP_INTERFACE`, or `RADIUS`. Defaults to `ANY`.<br/>        (Optional) `identity_provider` - The identity provider for the authentication. Valid values are `ANY`, `OKTA`, or `SPECIFIC_IDP`. Defaults to `ANY`. WARNING: Use of identity\_provider requires a feature flag to be enabled.<br/>    (Optional) `allow_access` - Whether to allow access. Defaults to `true`.<br/>    (Optional) `primary_factor` - The primary authentication factor. Only works for the Okta Identity Engine. Valid values are `PASSWORD_IDP` or `PASSWORD_IDP_ANY_FACTOR`. Defaults to `PASSWORD_IDP_ANY_FACTOR`.<br/>      `PASSWORD_IDP`: Users must always use a password to establish a session.<br/>      `PASSWORD_IDP_ANY_FACTOR`: Users can use any factor required by the app authentication policy to establish a session.<br/>    (Optional) `mfa` - A configuration for multi-factor authentication. `mfa` block as defined below.<br/>      (Optional) `required` - Whether to require multi-factor authentication. Defaults to `false`.<br/>      (Optional) `prompt_mode` - Indicates if the user should be challenged for a MFA based on the device being used, a factor session lifetime, or on every sign-in attempt. Valid values are `ALWAYS`, `SESSION`, or `DEVICE`. Defaults to `ALWAYS`.<br/>      (Optional) `session_duration` - Interval of time that must elapse before the user is challenged for MFA, if the value of `prompt_mode` is set to `SESSION`. Defaults to `15` minutes.<br/>      (Optional) `remember_device_by_default` - Whether Okta should automatically remember the device. Defaults to `false`.<br/>    (Optional) `session` - A configuration for session of the global session policy rule. `session` block as defined below.<br/>      (Optional) `duration` - Max minutes a session is active. Setting a maximum session lifetime reduces the risk of session cookie misuse or hijacking. The value of `0` means unlimited. Defaults to `720` (12 hours).<br/>      (Optional) `idle_timeout` - Max minutes a seesion can be idle. A global session will expire when the user is inactive for the specified amount of time, regardless of the maximum global session lifetime. Defaults to `120` (2 hours).<br/>      (Optional) `persistent_cookie_enabled` - Whether to enable persistent cookie. If enabled, when a user reopens their browser, and their session is still active, they won’t be asked to sign in again. Defaults to `false`. | <pre>list(object({<br/>    name     = string<br/>    priority = optional(number)<br/>    enabled  = optional(bool, true)<br/><br/>    condition = optional(object({<br/>      excluded_users = optional(set(string), [])<br/>      network = optional(object({<br/>        scope          = optional(string, "ANYWHERE")<br/>        excluded_zones = optional(set(string), [])<br/>        included_zones = optional(set(string), [])<br/>      }), {})<br/>      authentication = optional(object({<br/>        entrypoint        = optional(string, "ANY")<br/>        identity_provider = optional(string, "ANY")<br/>      }), {})<br/>    }), {})<br/><br/>    allow_access   = optional(bool, true)<br/>    primary_factor = optional(string, "PASSWORD_IDP_ANY_FACTOR")<br/>    mfa = optional(object({<br/>      required                   = optional(bool, false)<br/>      prompt_mode                = optional(string, "ALWAYS")<br/>      session_duration           = optional(number, 15)<br/>      remember_device_by_default = optional(bool, false)<br/>    }), {})<br/>    session = optional(object({<br/>      duration                  = optional(number, 60 * 12)<br/>      idle_timeout              = optional(number, 60 * 2)<br/>      persistent_cookie_enabled = optional(bool, false)<br/>    }), {})<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_description"></a> [description](#output\_description) | The description of the Okta Global Session Policy. |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether to enable the Okta Global Session Policy. |
| <a name="output_groups"></a> [groups](#output\_groups) | The information for the assigned groups of the Okta Global Session Policy. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Okta Global Session Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Okta Global Session Policy. |
| <a name="output_priority"></a> [priority](#output\_priority) | The priority of the Okta Global Session Policy. |
| <a name="output_rules"></a> [rules](#output\_rules) | The configuration for rules of the Okta Global Session Policy. |
<!-- END_TF_DOCS -->
