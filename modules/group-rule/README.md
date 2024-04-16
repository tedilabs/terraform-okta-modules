# group-rule

This module creates following resources.

- `okta_group_rule`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 3.31 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_okta"></a> [okta](#provider\_okta) | 3.35.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [okta_group_rule.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_expression"></a> [expression](#input\_expression) | (Optional) The Okta expression for Okta group rule. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Okta Group Rule. | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether to enable the Okta Group Rule. | `bool` | `true` | no |
| <a name="input_excluded_users"></a> [excluded\_users](#input\_excluded\_users) | (Optional) A list of user IDs that would be excluded when rules are processed. | `set(string)` | `[]` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | (Optional) A list of group ids to assign the users to. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether to enable the Okta Group Rule. |
| <a name="output_excluded_users"></a> [excluded\_users](#output\_excluded\_users) | The list of user IDs that would be excluded when rules are processed. |
| <a name="output_expression"></a> [expression](#output\_expression) | The Okta expression for Okta group rule. |
| <a name="output_groups"></a> [groups](#output\_groups) | The list of group ids to assign the users to. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Okta group rule. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Okta group rule. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
