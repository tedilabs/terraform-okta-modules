# group

This module creates following resources.

- `okta_group`
- `okta_group_role` (optional)

<!-- BEGIN_TF_DOCS -->
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
| [okta_group.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group) | resource |
| [okta_group_role.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/group_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Okta Group. | `string` | n/a | yes |
| <a name="input_admin_role_assignments"></a> [admin\_role\_assignments](#input\_admin\_role\_assignments) | (Optional) A configurations for admin roles to assign to the Okta group. Each item of `admin_role_assignments` block as defined below.<br>    (Required) `admin_role` - The admin role assigned to the group. Valid values are `SUPER_ADMIN`, `ORG_ADMIN`, `APP_ADMIN`, `USER_ADMIN`, `HELP_DESK_ADMIN`, `READ_ONLY_ADMIN` , `MOBILE_ADMIN`, `API_ACCESS_MANAGEMENT_ADMIN`, `REPORT_ADMIN`, `GROUP_MEMBERSHIP_ADMIN`. `USER_ADMIN` is the Group Administrator.<br>    (Optional) `target_apps` - A list of app names (name represents set of app instances, like `salesforce` or `facebook`), or a combination of app name and app instance ID (like `facebook.0oapsqQ6dv19pqyEo0g3`) you would like as the targets of the admin role. Only supported when used with the role type `APP_ADMIN`.<br>    (Optional) `target_groups` - A list of group IDs you would like as the targets of the admin role. Only supported when used with the role types: `GROUP_MEMBERSHIP_ADMIN`, `HELP_DESK_ADMIN`, or `USER_ADMIN`. | <pre>list(object({<br>    admin_role    = string<br>    target_apps   = optional(set(string), [])<br>    target_groups = optional(set(string), [])<br>  }))</pre> | `[]` | no |
| <a name="input_admin_role_notification_enabled"></a> [admin\_role\_notification\_enabled](#input\_admin\_role\_notification\_enabled) | (Optional) Whether to send the default Okta administrator emails. When this setting is disabled, the admins won't receive any of the notifications. These admins also won't have access to contact Okta Support and open support cases on behalf of your org. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_custom_profile_attributes"></a> [custom\_profile\_attributes](#input\_custom\_profile\_attributes) | (Optional) A map of custom profile attributes for group members. | `any` | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the Okta Group. | `string` | `"Managed by Terraform."` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_role_assignments"></a> [admin\_role\_assignments](#output\_admin\_role\_assignments) | The configurations for admin roles assigned to the Okta group. |
| <a name="output_admin_role_notification_enabled"></a> [admin\_role\_notification\_enabled](#output\_admin\_role\_notification\_enabled) | Whether to send the default Okta administrator emails. |
| <a name="output_custom_profile_attributes"></a> [custom\_profile\_attributes](#output\_custom\_profile\_attributes) | The custom profile attributes of the Okta group. |
| <a name="output_description"></a> [description](#output\_description) | The description of the Okta group. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Okta group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Okta group. |
<!-- END_TF_DOCS -->
