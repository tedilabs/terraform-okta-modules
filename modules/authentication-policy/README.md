# authentication-policy

This module creates following resources.

- `okta_app_signon_policy`
- `okta_app_signon_policy_rule` (optional)

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
| [okta_app_signon_policy.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_signon_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) A name of the Okta Authentication Policy. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the Okta Authentication Policy. | `string` | `"Managed by Terraform."` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_description"></a> [description](#output\_description) | The description of the Okta Authentication Policy. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Okta Authentication Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Okta Authentication Policy. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
