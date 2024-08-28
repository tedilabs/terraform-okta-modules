# authenticator

This module creates following resources.

- `okta_factor`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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
| [okta_factor.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/factor) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_type"></a> [type](#input\_type) | (Required) A type of the MFA provider. Valid values are `DUO`, `FIDO_U2F`, `FIDO_WEBAUTHN`, `GOOGLE_OTP`, `OKTA_CALL`, `OKTA_OTP`, `OKTA_PASSWORD`, `OKTA_PUSH`, `OKTA_QUESTION`, `OKTA_SMS`, `OKTA_EMAIL`, `RSA_TOKEN`, `SYMANTEC_VIP`, `YUBIKEY_TOKEN`, or `HOTP` | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether to activate the authenticator. Defaults to `true`. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether this factor is activated. |
| <a name="output_name"></a> [name](#output\_name) | The name of the MFA provider. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
