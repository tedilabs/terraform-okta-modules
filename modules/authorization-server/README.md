# authorization-server

This module creates following resources.

- `okta_auth_server`
- `okta_auth_server_claim` (optional)
- `okta_auth_server_claim_default` (optional)
- `okta_auth_server_policy` (optional)
- `okta_auth_server_policy_rule` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 6.5 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_okta"></a> [okta](#provider\_okta) | >= 6.5 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [okta_auth_server.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server) | resource |
| [okta_auth_server_claim.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server_claim) | resource |
| [okta_auth_server_policy.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server_policy) | resource |
| [okta_auth_server_policy_rule.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server_policy_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_audiences"></a> [audiences](#input\_audiences) | (Required) A set of recipients that the tokens are intended for. This becomes the aud claim in an access token. Currently Okta only supports a single value here. | `set(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) A name of the authorization server. | `string` | n/a | yes |
| <a name="input_access_policies"></a> [access\_policies](#input\_access\_policies) | (Optional) A list of access policies to be created for the authorization server. Each block of `access_policies` as defined below.<br/>    (Optional) `priority` - A priority of the access policy.<br/>    (Required) `name` - A name of the access policy.<br/>    (Optional) `description` - A description of the access policy. Defaults to `Managed by Terraform.`<br/>    (Optional) `enabled` - Whether to enable the access policy. Defaults to `true`.<br/>    (Optional) `assigned_clients` - A set of client IDs to be assigned to the access policy. `["ALL_CLIENTS"]` is a special value that can be used to whitelist all clients.<br/>    (Optional) `rules` - A configuration for rules of the access policy. Each item of `rules` block as defined below.<br/>      (Required) `name` - A name of the access policy rule. Must be unique within the access policy.<br/>      (Optional) `priority` - A priority of the access policy rule. Defaults to the position of the rule in `rules`, starting from `1`.<br/>      (Optional) `enabled` - Whether to enable the access policy rule. Defaults to `true`.<br/>      (Optional) `condition` - A condition of the access policy rule. `condition` block as defined below.<br/>        (Required) `grant_types` - A set of grant types to accept. Valid values are `authorization_code`, `client_credentials`, `implicit`, `interaction_code`, `password`, `urn:ietf:params:oauth:grant-type:device_code`, `urn:ietf:params:oauth:grant-type:saml2-bearer`, `urn:ietf:params:oauth:grant-type:token-exchange`.<br/>        (Optional) `scopes` - A set of scope names allowed for this rule. `["*"]` is a special value that allows all scopes. Defaults to `["*"]`.<br/>        (Optional) `included_users` - A set of user IDs to include.<br/>        (Optional) `excluded_users` - A set of user IDs to exclude.<br/>        (Optional) `included_groups` - A set of group IDs to include. `["EVERYONE"]` is a special value that includes every user assigned to the application. Defaults to `["EVERYONE"]`.<br/>        (Optional) `excluded_groups` - A set of group IDs to exclude.<br/>      (Optional) `access_token` - A configuration for the access token issued by the access policy rule. `access_token` block as defined below.<br/>        (Optional) `lifetime` - A lifetime of the access token in minutes. Okta accepts a value from `5` to `1440`. Defaults to `60` (1 hour).<br/>      (Optional) `refresh_token` - A configuration for the refresh token issued by the access policy rule. `refresh_token` block as defined below.<br/>        (Optional) `lifetime` - A lifetime of the refresh token in minutes. `0` means the refresh token never expires on its own, so its usable life is bounded by `window`. Defaults to `0`.<br/>        (Optional) `window` - A window in which the refresh token can be used in minutes. Okta accepts a value from `5` to `2628000` (5 years). Must be between `access_token.lifetime` and `refresh_token.lifetime` unless `refresh_token.lifetime` is `0`. Defaults to `10080` (7 days).<br/>      (Optional) `inline_hook` - The ID of the inline token hook to trigger. | <pre>list(object({<br/>    priority         = optional(number)<br/>    name             = string<br/>    description      = optional(string, "Managed by Terraform.")<br/>    enabled          = optional(bool, true)<br/>    assigned_clients = optional(set(string), [])<br/><br/>    rules = optional(list(object({<br/>      name     = string<br/>      priority = optional(number)<br/>      enabled  = optional(bool, true)<br/><br/>      condition = object({<br/>        grant_types = set(string)<br/>        scopes      = optional(set(string), ["*"])<br/><br/>        included_users  = optional(set(string), [])<br/>        excluded_users  = optional(set(string), [])<br/>        included_groups = optional(set(string), ["EVERYONE"])<br/>        excluded_groups = optional(set(string), [])<br/>      })<br/><br/>      access_token = optional(object({<br/>        lifetime = optional(number, 60)<br/>      }), {})<br/>      refresh_token = optional(object({<br/>        lifetime = optional(number, 0)<br/>        window   = optional(number, 60 * 24 * 7)<br/>      }), {})<br/><br/>      inline_hook = optional(string)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_claims"></a> [claims](#input\_claims) | (Optional) A list of claims to be created for the authorization server. Each block of `claims` as defined below.<br/>    (Required) `token_type` - The token type of the claim. Valid values are `ID_TOKEN`, `ACCESS_TOKEN`.<br/>    (Optional) `always_include_in_token` - Whether to always include the claim in the token. Defaults to `true`.<br/>    (Required) `name` - The name of the claim.<br/>    (Optional) `value_type` - The value type of the claim. Valid values are `EXPRESSIONS` and `GROUPS`. Defaults to `EXPRESSION`.<br/>    (Optional) `operator` - The operator of group filter if `value_type` is `GROUPS`. Valid values are `STARTS_WITH`, `EQUALS`, `CONTAINS`, `REGEX`. Defaults to `REGEX`.<br/>    (Required) `value` - The value of the claim.<br/>    (Optional) `enabled` - Whether the claim is enabled. Defaults to `true`.<br/>    (Optional) `scopes` - A set of scope names the auth server claim is tied to. | <pre>list(object({<br/>    token_type              = string<br/>    always_include_in_token = optional(bool, true)<br/><br/>    name       = string<br/>    value_type = optional(string, "EXPRESSION")<br/>    operator   = optional(string, "REGEX")<br/>    value      = string<br/><br/>    enabled = optional(bool, true)<br/>    scopes  = optional(set(string), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the authorization server. Defaults to `Managed by Terraform.` | `string` | `"Managed by Terraform."` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether to activate the authorization server. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_issuer"></a> [issuer](#input\_issuer) | (Optional) A configuration for issuer of the authorization server. `issuer` block as defined below.<br/>    (Optional) `mode` - The issuer mode of the authorization server. Valid values are `ORG_URL`, `CUSTOM_URL` and `DYNAMIC`. Defaults to `DYNAMIC`. | <pre>object({<br/>    mode = optional(string, "DYNAMIC")<br/>  })</pre> | `{}` | no |
| <a name="input_signing_key"></a> [signing\_key](#input\_signing\_key) | (Optional) A signing key configuration of the authorization server. `signing_key` block as defined below.<br/>    (Optional) `rotation_mode` - The signing key rotation mode of the authorization server. Valid values are `MANUAL` and `AUTO`. Defaults to `AUTO`. | <pre>object({<br/>    rotation_mode = optional(string, "AUTO")<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_access_policies"></a> [access\_policies](#output\_access\_policies) | The access policies of the authorization server. |
| <a name="output_audiences"></a> [audiences](#output\_audiences) | The audiences of the authorization server. |
| <a name="output_claims"></a> [claims](#output\_claims) | The claims of the authorization server. |
| <a name="output_description"></a> [description](#output\_description) | The description of the authorization server. |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether this authorization server is activated. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the authorization server. |
| <a name="output_issuer"></a> [issuer](#output\_issuer) | The issuer configuration of the authorization server. |
| <a name="output_kid"></a> [kid](#output\_kid) | The ID of the JSON Web Key used for signing tokens issued by the authorization server. |
| <a name="output_name"></a> [name](#output\_name) | The display name of the authorization server. |
| <a name="output_signing_key"></a> [signing\_key](#output\_signing\_key) | The signing key configuration of the authorization server. |
<!-- END_TF_DOCS -->
