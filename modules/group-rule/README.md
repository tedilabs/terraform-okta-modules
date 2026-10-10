# group-rule

This module creates following resources.

- `okta_group_rule`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 6.5 |
| <a name="requirement_telemetry"></a> [telemetry](#requirement\_telemetry) | >= 0.2.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_okta"></a> [okta](#provider\_okta) | >= 6.5 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [okta_group_rule.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group_rule) | resource |
| [okta_group.this](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_expression"></a> [expression](#input\_expression) | (Required) The Okta expression for Okta group rule. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Okta Group Rule. | `string` | n/a | yes |
| <a name="input_cascade_on_delete"></a> [cascade\_on\_delete](#input\_cascade\_on\_delete) | (Optional) Whether to remove users added by this rule from the assigned group after deleting this resource. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether to enable the Okta Group Rule. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_excluded_users"></a> [excluded\_users](#input\_excluded\_users) | (Optional) A set of user IDs that would be excluded when rules are processed. | `set(string)` | `[]` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | (Optional) A set of group ids to assign the users to. | `set(string)` | `[]` | no |
| <a name="input_telemetry"></a> [telemetry](#input\_telemetry) | (Optional) A configuration to collect telemetry data for the module. This is used to improve the module and its features. To send pseudonyms instead of identifying values such as the hostname and the Git remote, set `pseudonymization_enabled` to `true`. Pseudonyms are not anonymous; to keep data from being sent, disable its collector. The default configuration enables telemetry collection for machine, network, git, github, github actions, HCP Terraform, terraform, and toolchain. You can disable telemetry collection by setting `enabled` to `false`. `telemetry` block as defined below.<br/>    (Optional) `enabled` - Whether to enable telemetry collection. Default is `true`.<br/>    (Optional) `capture_machine` - Whether to capture machine information. Default is `true`.<br/>    (Optional) `capture_network` - Whether to capture network information. Default is `true`.<br/>    (Optional) `capture_git` - Whether to capture git information. Default is `true`.<br/>    (Optional) `capture_github` - Whether to capture GitHub information. Default is `true`.<br/>    (Optional) `capture_github_actions` - Whether to capture GitHub Actions information. Default is `true`.<br/>    (Optional) `capture_hcp_terraform` - Whether to capture HCP Terraform information. Default is `true`.<br/>    (Optional) `capture_terraform` - Whether to capture Terraform information. Default is `true`.<br/>    (Optional) `capture_toolchain` - Whether to capture toolchain information. Default is `true`.<br/>    (Optional) `pseudonymization_enabled` - Whether to enable pseudonymization of the captured data. Default is `false`. | <pre>object({<br/>    enabled = optional(bool, true)<br/><br/>    capture_machine        = optional(bool, true)<br/>    capture_network        = optional(bool, true)<br/>    capture_git            = optional(bool, true)<br/>    capture_github         = optional(bool, true)<br/>    capture_github_actions = optional(bool, true)<br/>    capture_hcp_terraform  = optional(bool, true)<br/>    capture_terraform      = optional(bool, true)<br/>    capture_toolchain      = optional(bool, true)<br/><br/>    pseudonymization_enabled = optional(bool, false)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether to enable the Okta Group Rule. |
| <a name="output_excluded_users"></a> [excluded\_users](#output\_excluded\_users) | The list of user IDs that would be excluded when rules are processed. |
| <a name="output_expression"></a> [expression](#output\_expression) | The Okta expression for Okta group rule. |
| <a name="output_groups"></a> [groups](#output\_groups) | The information for the assigned groups by the Okta group rule. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Okta group rule. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Okta group rule. |
<!-- END_TF_DOCS -->
