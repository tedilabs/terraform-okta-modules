# authenticator

This module creates following resources.

- `okta_authenticator`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_okta"></a> [okta](#provider\_okta) | 6.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [okta_authenticator.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/authenticator) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) A display name of the authenticator. | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | (Required) A type of the MFA provider. Valid values are `CUSTOM_OTP`, `DUO`, `EXTERNAL_IDP`, `GOOGLE_OTP`, `OKTA_EMAIL`, `OKTA_PASSWORD`, `OKTA_VERIFY`, `ONPREM_MFA`, `PHONE_NUMBER`, `RSA_TOKEN`, `SECURITY_QUESTION`, or `WEBAUTHN` | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether to activate the authenticator. Defaults to `true`. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_category"></a> [category](#output\_category) | The category of the authenticator provider. |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether this authenticator is activated. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the authenticator. |
| <a name="output_name"></a> [name](#output\_name) | The display name of the authenticator. |
| <a name="output_settings"></a> [settings](#output\_settings) | The settings of the authenticator |
| <a name="output_type"></a> [type](#output\_type) | The type of the authenticator provider. |
<!-- END_TF_DOCS -->
