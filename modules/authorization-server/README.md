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
| [okta_auth_server.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server) | resource |
| [okta_auth_server_claim.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server_claim) | resource |
| [okta_auth_server_policy.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/auth_server_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_audiences"></a> [audiences](#input\_audiences) | (Required) A set of recipients that the tokens are intended for. This becomes the aud claim in an access token. Currently Okta only supports a single value here. | `set(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) A name of the authorization server. | `string` | n/a | yes |
| <a name="input_access_policies"></a> [access\_policies](#input\_access\_policies) | (Optional) A list of access policies to be created for the authorization server. Each block of `access_policies` as defined below.<br/>    (Optional) `priority` - A priority of the access policy.<br/>    (Required) `name` - A name of the access policy.<br/>    (Optional) `description` - A description of the access policy. Defaults to `Managed by Terraform.`<br/>    (Optional) `enabled` - Whether to enable the access policy. Defaults to `true`.<br/>    (Optional) `assigned_clients` - A set of client IDs to be assigned to the access policy. `["ALL_CLIENTS"]` is a special value that can be used to whitelist all clients. | <pre>list(object({<br/>    priority         = optional(number)<br/>    name             = string<br/>    description      = optional(string, "Managed by Terraform.")<br/>    enabled          = optional(bool, true)<br/>    assigned_clients = optional(set(string), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_claims"></a> [claims](#input\_claims) | (Optional) A list of claims to be created for the authorization server. Each block of `claims` as defined below.<br/>    (Required) `token_type` - The token type of the claim. Valid values are `ID_TOKEN`, `ACCESS_TOKEN`.<br/>    (Optional) `always_include_in_token` - Whether to always include the claim in the token. Defaults to `true`.<br/>    (Required) `name` - The name of the claim.<br/>    (Optional) `value_type` - The value type of the claim. Valid values are `EXPRESSIONS` and `GROUPS`. Defaults to `EXPRESSION`.<br/>    (Optional) `operator` - The operator of group filter if `value_type` is `GROUPS`. Valid values are `STARTS_WITH`, `EQUALS`, `CONTAINS`, `REGEX`. Defaults to `REGEX`.<br/>    (Required) `value` - The value of the claim.<br/>    (Optional) `enabled` - Whether the claim is enabled. Defaults to `true`.<br/>    (Optional) `scopes` - A set of scope names the auth server claim is tied to. | <pre>list(object({<br/>    token_type              = string<br/>    always_include_in_token = optional(bool, true)<br/><br/>    name       = string<br/>    value_type = optional(string, "EXPRESSION")<br/>    operator   = optional(string, "REGEX")<br/>    value      = string<br/><br/>    enabled = optional(bool, true)<br/>    scopes  = optional(set(string), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the authorization server. Defaults to `Managed by Terraform.` | `string` | `"Managed by Terraform."` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether to activate the authorization server. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_issuer"></a> [issuer](#input\_issuer) | (Optional) A configuration for issuer of the authorization server. `issuer` block as defined below.<br/>    (Optional) `mode` - The issuer mode of the authorization server. Valid values are `ORG_URL`, `CUSTOM_URL` and `DYNAMIC`. Defaults to `DYNAMIC`. | <pre>object({<br/>    mode = optional(string, "DYNAMIC")<br/>  })</pre> | `{}` | no |
| <a name="input_signing_key"></a> [signing\_key](#input\_signing\_key) | (Optional) A signing key configuration of the authorization server. `signing_key` block as defined below.<br/>    (Optional) `rotation_mode` - The signing key rotation mode of the authorization server. Valid values are `MANUAL` and `AUTO`. Defaults to `AUTO`. | <pre>object({<br/>    rotation_mode = optional(string, "AUTO")<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
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
