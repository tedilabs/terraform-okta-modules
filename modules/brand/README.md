# brand

This module creates following resources.

- `okta_brand`
- `okta_domain` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_datadog"></a> [datadog](#requirement\_datadog) | >= 3.37 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_datadog"></a> [datadog](#provider\_datadog) | 3.37.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [datadog_team.this](https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/team) | resource |
| [datadog_team_link.this](https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/team_link) | resource |
| [datadog_team_permission_setting.edit](https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/team_permission_setting) | resource |
| [datadog_team_permission_setting.membership](https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/team_permission_setting) | resource |
| [datadog_team.this](https://registry.terraform.io/providers/DataDog/datadog/latest/docs/data-sources/team) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_handle"></a> [handle](#input\_handle) | (Required) The identifier of the team. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) A name to help you identify the team. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description to help you identify the team. | `string` | `"Managed by Terraform."` | no |
| <a name="input_links"></a> [links](#input\_links) | (Optional) A list of configurations for the team links. Each block of `teams` block as defined below.<br>    (Required) `name` - A label to help you identify the link.<br>    (Required) `url` - The URL for the link.<br>    (Optional) `priority` - The link's position, used to sort links for the team. | <pre>list(object({<br>    name     = string<br>    url      = string<br>    priority = optional(number)<br>  }))</pre> | `[]` | no |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | (Optional) A configurations for the team permissions. `permissions` block as defined below.<br>    (Optional) `edit` - The scope who can edit the team. Users with the `User Access Manage` permission can always add members, remove members, and edit this setting. Defaults to `TEAM_MEMBER`.<br>    (Optional) `membership` - The scope who can manage the team's membership. Users with the `Teams Manage` permission can always edit team details and this setting. Defaults to `TEAM_MANAGER`. | <pre>object({<br>    edit       = optional(string, "TEAM_MEMBER")<br>    membership = optional(string, "TEAM_MANAGER")<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_description"></a> [description](#output\_description) | The description of the team. |
| <a name="output_handle"></a> [handle](#output\_handle) | The handle of the team. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the team. |
| <a name="output_link_count"></a> [link\_count](#output\_link\_count) | The number of links belonging to the team. |
| <a name="output_links"></a> [links](#output\_links) | The configurations for the team links. |
| <a name="output_name"></a> [name](#output\_name) | The name of the team. |
| <a name="output_permissions"></a> [permissions](#output\_permissions) | The configurations for the team permissions. |
| <a name="output_user_count"></a> [user\_count](#output\_user\_count) | The number of users belonging to the team. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
