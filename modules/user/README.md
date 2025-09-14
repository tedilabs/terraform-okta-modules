# user

This module creates following resources.

- `okta_user`
- `okta_user_admin_roles`
- `okta_user_group_memberships`
- `okta_admin_role_targets` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 4.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_okta"></a> [okta](#provider\_okta) | 6.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [okta_admin_role_targets.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/admin_role_targets) | resource |
| [okta_user.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/user) | resource |
| [okta_user_admin_roles.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/user_admin_roles) | resource |
| [okta_user_group_memberships.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/user_group_memberships) | resource |
| [okta_group.this](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email"></a> [email](#input\_email) | (Required) A primary email address for the user. | `string` | n/a | yes |
| <a name="input_first_name"></a> [first\_name](#input\_first\_name) | (Required) A given name of the user. | `string` | n/a | yes |
| <a name="input_last_name"></a> [last\_name](#input\_last\_name) | (Required) A family name of the user. | `string` | n/a | yes |
| <a name="input_phone"></a> [phone](#input\_phone) | (Required) A phone number of the user for the work. | `string` | n/a | yes |
| <a name="input_secondary_email"></a> [secondary\_email](#input\_secondary\_email) | (Required) A secondary email address for the user. Typically used for account recovery. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | (Required) Unique identifier for the user. | `string` | n/a | yes |
| <a name="input_address_info"></a> [address\_info](#input\_address\_info) | (Optional) A configuration for the user address. `address_info` block as defined below.<br/>    (Optional) `country_code` - A country code of the user address. Formatted with ISO 3166-1<br/>    alpha 2 code.<br/>    (Optional) `state` - A state or region of the user address.<br/>    (Optional) `city` - A city or locality of the user address.<br/>    (Optional) `street_address` - A full street address of the user address.<br/>    (Optional) `postal_address` - A mailing address of the user address.<br/>    (Optional) `zip_code` - A postal code of the user address. | <pre>object({<br/>    country_code   = optional(string)<br/>    state          = optional(string)<br/>    city           = optional(string)<br/>    street_address = optional(string)<br/>    postal_address = optional(string)<br/>    zip_code       = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_admin_role_assignments"></a> [admin\_role\_assignments](#input\_admin\_role\_assignments) | (Optional) A configurations for admin roles to assign to the Okta user. Each item of `admin_role_assignments` block as defined below.<br/>    (Required) `admin_role` - The admin role assigned to the user. Valid values are `SUPER_ADMIN`, `ORG_ADMIN`, `APP_ADMIN`, `USER_ADMIN`, `HELP_DESK_ADMIN`, `READ_ONLY_ADMIN` , `MOBILE_ADMIN`, `API_ACCESS_MANAGEMENT_ADMIN`, `REPORT_ADMIN`, `GROUP_MEMBERSHIP_ADMIN`. `USER_ADMIN` is the Group Administrator.<br/>    (Optional) `target_apps` - A list of app names (name represents set of app instances, like `salesforce` or `facebook`), or a combination of app name and app instance ID (like `facebook.0oapsqQ6dv19pqyEo0g3`) you would like as the targets of the admin role. Only supported when used with the role type `APP_ADMIN`.<br/>    (Optional) `target_groups` - A list of group IDs you would like as the targets of the admin role. Only supported when used with the role types: `GROUP_MEMBERSHIP_ADMIN`, `HELP_DESK_ADMIN`, or `USER_ADMIN`. | <pre>list(object({<br/>    admin_role    = string<br/>    target_apps   = optional(set(string), [])<br/>    target_groups = optional(set(string), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_admin_role_notification_enabled"></a> [admin\_role\_notification\_enabled](#input\_admin\_role\_notification\_enabled) | (Optional) Whether to send the default Okta administrator emails. When this setting is disabled, the admins won't receive any of the notifications. These admins also won't have access to contact Okta Support and open support cases on behalf of your org. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_cost_center"></a> [cost\_center](#input\_cost\_center) | (Optional) A name of the cost center assigned to the user. | `string` | `null` | no |
| <a name="input_custom_attributes"></a> [custom\_attributes](#input\_custom\_attributes) | (Optional) The object for custom profile attributes of the user. | `any` | `{}` | no |
| <a name="input_custom_attributes_to_ignore"></a> [custom\_attributes\_to\_ignore](#input\_custom\_attributes\_to\_ignore) | (Optional) A set of custom attribute keys that should be excluded from being managed by Terraform. This is useful in situations where specific custom fields may contain sensitive information and should be managed outside of Terraform. | `set(string)` | `[]` | no |
| <a name="input_department"></a> [department](#input\_department) | (Optional) The department name of the user. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | (Optional) A name of the user, suitable to display to end users. | `string` | `null` | no |
| <a name="input_division"></a> [division](#input\_division) | (Optional) The division name of the user. | `string` | `null` | no |
| <a name="input_employee_number"></a> [employee\_number](#input\_employee\_number) | (Optional) A company-assigned unique identifier for the user. | `string` | `null` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | (Optional) A set of group IDs for the group memberships of the user. | `set(string)` | `[]` | no |
| <a name="input_honorific_prefix"></a> [honorific\_prefix](#input\_honorific\_prefix) | (Optional) An honorific prefix preceding a name such as Dr/Mrs/Mr. | `string` | `null` | no |
| <a name="input_honorific_suffix"></a> [honorific\_suffix](#input\_honorific\_suffix) | (Optional) An honorific suffix following a name such as M.D./PhD/MSCSW. | `string` | `null` | no |
| <a name="input_locale"></a> [locale](#input\_locale) | (Optional) A locale value is a concatenation of the ISO 639-1 two-letter language code, an underscore, and the ISO 3166-1 two-letter country code. For example, `en_US` specifies the language English and country US. Defaults to `en_US`. | `string` | `"en_US"` | no |
| <a name="input_manager"></a> [manager](#input\_manager) | (Optional) A configuration for the user's manager. `manager` block as defined below.<br/>    (Optional) `id` - The ID of the user's manager.<br/>    (Optional) `name` - The `display_name` of the user's manager. | <pre>object({<br/>    id   = optional(string)<br/>    name = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_middle_name"></a> [middle\_name](#input\_middle\_name) | (Optional) A middle name of the user. | `string` | `null` | no |
| <a name="input_nick_name"></a> [nick\_name](#input\_nick\_name) | (Optional) A casual name to address the user. | `string` | `null` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | (Optional) The organization name of the user. | `string` | `null` | no |
| <a name="input_preferred_language"></a> [preferred\_language](#input\_preferred\_language) | (Optional) A preferred written or spoken languages of the user. Formatted with RFC 7231. | `string` | `null` | no |
| <a name="input_primary_phone"></a> [primary\_phone](#input\_primary\_phone) | (Optional) A primary phone number of the user such as home number. | `string` | `null` | no |
| <a name="input_profile_url"></a> [profile\_url](#input\_profile\_url) | (Optional) The URL of the user's online profile. | `string` | `null` | no |
| <a name="input_status"></a> [status](#input\_status) | (Optional) A status of the user account which provides information about the user account and whether administrative or user action is required. Valid values are `STAGED`, `ACTIVE`, `SUSPENDED`, `DEPROVISIONED`. Defaults to `ACTIVE`. | `string` | `"ACTIVE"` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | (Optional) A time zone of the user like `Asia/Seoul`. | `string` | `null` | no |
| <a name="input_title"></a> [title](#input\_title) | (Optional) A title of the user like "Vice President". | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_info"></a> [address\_info](#output\_address\_info) | The address information of the user. |
| <a name="output_admin_role_assignments"></a> [admin\_role\_assignments](#output\_admin\_role\_assignments) | The configurations for admin roles assigned to the Okta user. |
| <a name="output_admin_role_notification_enabled"></a> [admin\_role\_notification\_enabled](#output\_admin\_role\_notification\_enabled) | Whether to send the default Okta administrator emails. |
| <a name="output_cost_center"></a> [cost\_center](#output\_cost\_center) | The name of the cost center assigned to the user. |
| <a name="output_custom_attributes"></a> [custom\_attributes](#output\_custom\_attributes) | The object for custom profile attributes of the user. |
| <a name="output_department"></a> [department](#output\_department) | The department name of the user. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the user. |
| <a name="output_division"></a> [division](#output\_division) | The division name of the user. |
| <a name="output_email"></a> [email](#output\_email) | The primary email address of the user. |
| <a name="output_employee_number"></a> [employee\_number](#output\_employee\_number) | The company-assigned unique identifier for the user. |
| <a name="output_first_name"></a> [first\_name](#output\_first\_name) | The first name of the user. |
| <a name="output_groups"></a> [groups](#output\_groups) | The information for the group memberships of the user. |
| <a name="output_honorific_prefix"></a> [honorific\_prefix](#output\_honorific\_prefix) | An honorific prefix preceding a name. |
| <a name="output_honorific_suffix"></a> [honorific\_suffix](#output\_honorific\_suffix) | An honorific suffix following a name. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the user. |
| <a name="output_last_name"></a> [last\_name](#output\_last\_name) | The family name of the user. |
| <a name="output_manager"></a> [manager](#output\_manager) | The manager information of the user. |
| <a name="output_middle_name"></a> [middle\_name](#output\_middle\_name) | The middle name of the user. |
| <a name="output_nick_name"></a> [nick\_name](#output\_nick\_name) | The casual name of the user. |
| <a name="output_organization"></a> [organization](#output\_organization) | The organization name of the user. |
| <a name="output_phone"></a> [phone](#output\_phone) | The phone number of the user for the work. |
| <a name="output_preferences"></a> [preferences](#output\_preferences) | The configurations of the user preferences. |
| <a name="output_primary_phone"></a> [primary\_phone](#output\_primary\_phone) | The primary phone number of the user. |
| <a name="output_profile_url"></a> [profile\_url](#output\_profile\_url) | The URL of the user's online profile. |
| <a name="output_secondary_email"></a> [secondary\_email](#output\_secondary\_email) | The secondary email address of the user. |
| <a name="output_status"></a> [status](#output\_status) | The status of the user. |
| <a name="output_title"></a> [title](#output\_title) | The title of the user. |
<!-- END_TF_DOCS -->
