# global-session-policy

This module creates following resources.

- `okta_policy_signon`
- `okta_policy_rule_signon` (optional)

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

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_description"></a> [description](#output\_description) | The description of the Okta Global Session Policy. |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether to enable the Okta Global Session Policy. |
| <a name="output_groups"></a> [groups](#output\_groups) | The information for the assigned groups of the Okta Global Session Policy. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Okta Global Session Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Okta Global Session Policy. |
| <a name="output_priority"></a> [priority](#output\_priority) | The priority of the Okta Global Session Policy. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
