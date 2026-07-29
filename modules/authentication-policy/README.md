# authentication-policy

This module creates following resources.

- `okta_app_signon_policy`
- `okta_app_signon_policy_rule` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 6.5 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_okta"></a> [okta](#provider\_okta) | 6.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [okta_app_signon_policy.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_signon_policy) | resource |
| [okta_app_signon_policy_rule.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_signon_policy_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the Okta Authentication Policy. | `string` | `"Managed by Terraform."` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) A name of the Okta Authentication Policy. | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | (Optional) A configuration for rules of the Okta Authentication Policy. Each item of `rules` block as defined below.<br/>    (Required) `name` - A name of the authentication policy rule.<br/>    (Optional) `priority` - A priority of the authentication policy rule.<br/>    (Optional) `enabled` - Whether to enable the authentication policy rule. Defaults to `true`.<br/>    (Optional) `condition` - A condition of the authentication policy rule. `condition` block as defined below.<br/>      (Optional) `excluded_users` - A set of user IDs to exclude.<br/>      (Optional) `included_users` - A set of user IDs to include.<br/>      (Optional) `excluded_groups` - A set of group IDs to exclude.<br/>      (Optional) `included_groups` - A set of group IDs to include.<br/>      (Optional) `excluded_user_types` - A set of user type IDs to exclude.<br/>      (Optional) `included_user_types` - A set of user type IDs to include.<br/>      (Optional) `network` - A configuration for network conditions.<br/>        (Optional) `scope` - Valid values are `ANYWHERE`, `ON_NETWORK`, `OFF_NETWORK`, or `ZONE`. Defaults to `ANYWHERE`.<br/>        (Optional) `excluded_zones` - A set of excluded network zone IDs.<br/>        (Optional) `included_zones` - A set of included network zone IDs.<br/>      (Optional) `device` - A configuration for device conditions.<br/>        (Optional) `registered` - Whether the device must be registered.<br/>        (Optional) `managed` - Whether the device must be managed. Requires `registered` to be `true`.<br/>        (Optional) `assurances` - A set of included device assurance policy IDs.<br/>      (Optional) `platforms` - A set of platform conditions.<br/>      (Optional) `risk_score` - Valid values are `ANY`, `LOW`, `MEDIUM`, or `HIGH`. Defaults to `ANY`.<br/>      (Optional) `expression` - An Okta Expression Language condition.<br/>    (Optional) `allow_access` - Whether to allow access. Defaults to `true`.<br/>    (Optional) `verification` - A configuration for authentication requirements.<br/>      (Optional) `type` - The verification method type. Valid value is `ASSURANCE`, which verifies that the selected<br/>        factor count and constraints are satisfied. The Okta API also defines `AUTH_METHOD_CHAIN`, which prompts for<br/>        specific authentication methods in a configured sequence, but this module doesn't support it because<br/>        authentication method chains aren't implemented. Defaults to `ASSURANCE`.<br/>      (Optional) `factor_mode` - Valid values are `1FA` or `2FA`. Defaults to `2FA`.<br/>      (Optional) `reauthentication_timeout` - The maximum authentication age after which the user must re-authenticate,<br/>        regardless of activity, in ISO 8601 duration format. Maps to `verificationMethod.reauthenticateIn` in the Okta<br/>        Policy API and `re_authentication_frequency` in the Terraform Provider. `PT0S` means every sign-in attempt and<br/>        Okta uses `PT43800H` to represent once per active Okta global session. Defaults to `PT43800H`.<br/>      (Optional) `inactivity_timeout` - The duration without authentication activity after which the user must<br/>        re-authenticate, in ISO 8601 duration format. Maps to `verificationMethod.inactivityPeriod` in the Okta Policy<br/>        API and `inactivity_period` in the Terraform Provider. By default, no inactivity-based re-authentication is<br/>        configured.<br/>      (Optional) `constraints` - Knowledge and possession factor constraints. | <pre>list(object({<br/>    name     = string<br/>    priority = optional(number)<br/>    enabled  = optional(bool, true)<br/><br/>    condition = optional(object({<br/>      excluded_users      = optional(set(string), [])<br/>      included_users      = optional(set(string), [])<br/>      excluded_groups     = optional(set(string), [])<br/>      included_groups     = optional(set(string), [])<br/>      excluded_user_types = optional(set(string), [])<br/>      included_user_types = optional(set(string), [])<br/>      network = optional(object({<br/>        scope          = optional(string, "ANYWHERE")<br/>        excluded_zones = optional(set(string), [])<br/>        included_zones = optional(set(string), [])<br/>      }), {})<br/>      device = optional(object({<br/>        registered = optional(bool)<br/>        managed    = optional(bool)<br/>        assurances = optional(set(string), [])<br/>      }), {})<br/>      platforms = optional(set(object({<br/>        type          = string<br/>        os_type       = string<br/>        os_expression = optional(string)<br/>      })), [])<br/>      risk_score = optional(string, "ANY")<br/>      expression = optional(string)<br/>    }), {})<br/><br/>    allow_access = optional(bool, true)<br/>    verification = optional(object({<br/>      type                     = optional(string, "ASSURANCE")<br/>      factor_mode              = optional(string, "2FA")<br/>      reauthentication_timeout = optional(string, "PT43800H")<br/>      inactivity_timeout       = optional(string)<br/>      constraints = optional(list(object({<br/>        knowledge = optional(object({<br/>          required = optional(bool, true)<br/>          types    = optional(set(string), [])<br/>        }))<br/>        possession = optional(object({<br/>          required            = optional(bool, true)<br/>          device_bound        = optional(string)<br/>          hardware_protection = optional(string)<br/>          phishing_resistant  = optional(string)<br/>          user_presence       = optional(string)<br/>          user_verification   = optional(string)<br/>        }))<br/>      })), [])<br/>    }), {})<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_description"></a> [description](#output\_description) | The description of the Okta Authentication Policy. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Okta Authentication Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Okta Authentication Policy. |
| <a name="output_rules"></a> [rules](#output\_rules) | The configuration for rules of the Okta Authentication Policy. |
<!-- END_TF_DOCS -->
