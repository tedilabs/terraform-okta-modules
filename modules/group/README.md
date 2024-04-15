# group

This module creates following resources.

- `okta_group`
- `okta_group_role` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 3.31 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_okta"></a> [okta](#provider\_okta) | 3.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [okta_group.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group) | resource |
| [okta_group_role.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Okta Group. | `string` | n/a | yes |
| <a name="input_custom_profile_attributes"></a> [custom\_profile\_attributes](#input\_custom\_profile\_attributes) | (Optional) A map of custom profile attributes for group members. | `any` | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the Okta Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | (Optional) A list of roles to assign to the Okta group. Each item of `roles` block as defined below.<br>    (Required) `role` - The admin role assigned to the group. Valid values are `SUPER_ADMIN`, `ORG_ADMIN`, `APP_ADMIN`, `USER_ADMIN`, `HELP_DESK_ADMIN`, `READ_ONLY_ADMIN` , `MOBILE_ADMIN`, `API_ACCESS_MANAGEMENT_ADMIN`, `REPORT_ADMIN`, `GROUP_MEMBERSHIP_ADMIN`. `USER_ADMIN` is the Group Administrator.<br>    (Optional) `target_groups` - A list of group IDs you would like as the targets of the admin role. Only supported when used with the role types: `GROUP_MEMBERSHIP_ADMIN`, `HELP_DESK_ADMIN`, or `USER_ADMIN`.<br>    (Optional) `target_apps` - A list of app names (name represents set of app instances, like `salesforce` or `facebook`), or a combination of app name and app instance ID (like `facebook.0oapsqQ6dv19pqyEo0g3`) you would like as the targets of the admin role. Only supported when used with the role type `APP_ADMIN`.<br>    (Optional) `notification_enabled` - Whether to send the default Okta administrator emails. When this setting is disabled, the admins won't receive any of the notifications. These admins also won't have access to contact Okta Support and open support cases on behalf of your org. | `any` | `[]` | no |
| <a name="input_skip_users"></a> [skip\_users](#input\_skip\_users) | (Optional) Whether to allow the group to skip users sync (it's also can be provided during import). Default to `true`. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_profile_attributes"></a> [custom\_profile\_attributes](#output\_custom\_profile\_attributes) | The custom profile attributes of the Okta group. |
| <a name="output_description"></a> [description](#output\_description) | The description of the Okta group. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Okta group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Okta group. |
| <a name="output_roles"></a> [roles](#output\_roles) | A list of roles assigned to the Okta group. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
