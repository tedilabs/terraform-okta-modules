# bookmark-app

This module creates following resources.

- `okta_app_bookmark`
- `okta_app_group_assignments`
- `okta_app_user` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 6.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_okta"></a> [okta](#provider\_okta) | 6.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [okta_app_bookmark.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_bookmark) | resource |
| [okta_app_group_assignments.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_group_assignments) | resource |
| [okta_app_user.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_user) | resource |
| [okta_group.this](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/group) | data source |
| [okta_user.this](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The label of the Okta bookmark application. The application's display name. | `string` | n/a | yes |
| <a name="input_url"></a> [url](#input\_url) | (Required) The URL of the Okta bookmark application. | `string` | n/a | yes |
| <a name="input_custom_error_page"></a> [custom\_error\_page](#input\_custom\_error\_page) | (Optional) The URL for custom error page. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether to enable the Okta bookmark application. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_group_assignments"></a> [group\_assignments](#input\_group\_assignments) | (Optional) A configurations to assign groups for the Okta bookmark application. Each item of `group_assignments` block as defined below.<br/>    (Required) `group` - The ID of the group to assign.<br/>    (Optional) `priority` - A priority of group assignment<br/>    (Optional) `profile` - JSON document containing application profile. | <pre>list(object({<br/>    group    = string<br/>    priority = optional(number)<br/>    profile  = optional(map(string), {})<br/>  }))</pre> | `[]` | no |
| <a name="input_hide_app_on_ios"></a> [hide\_app\_on\_ios](#input\_hide\_app\_on\_ios) | (Optional) Whether to hide application icon on mobile app. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_hide_app_on_web"></a> [hide\_app\_on\_web](#input\_hide\_app\_on\_web) | (Optional) Whether to hide application icon on web. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_logo_path"></a> [logo\_path](#input\_logo\_path) | (Optional) A local file path to the logo. The file must be in PNG, JPG, or GIF format, and less than 1 MB in size. | `string` | `null` | no |
| <a name="input_notes"></a> [notes](#input\_notes) | (Optional) A configurations for application notes. `notes` block as defined below.<br/>    (Optional) `admin` - Application notes for admins.<br/>    (Optional) `user` - Application notes for end users. | <pre>object({<br/>    admin = optional(string, "")<br/>    user  = optional(string, "")<br/>  })</pre> | `{}` | no |
| <a name="input_sign_on"></a> [sign\_on](#input\_sign\_on) | (Optional) A configurations for application sign-on. `sign_on` block as defined below.<br/>    (Optional) `authentication_policy` - The ID of the authentication policy to associate to the applicatioauthentication policy to associate to the application. If this is removed from the application the default sign-on-policy will be associated with this application. | <pre>object({<br/>    authentication_policy = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_user_assignments"></a> [user\_assignments](#input\_user\_assignments) | (Optional) A configurations to assign users for the Okta bookmark application. Each item of `user_assignments` block as defined below.<br/>    (Required) `user` - The ID of the user to assign.<br/>    (Optional) `profile` - JSON document containing application profile.<br/>    (Optional) `username` - The username for the app user. In case the user is assigned to the app with SHARED\_USERNAME\_AND\_PASSWORD credentials scheme, this field will be computed and should not be set.<br/>    (Optional) `password` - The password for the app user. | <pre>list(object({<br/>    user     = string<br/>    profile  = optional(map(string), {})<br/>    username = optional(string)<br/>    password = optional(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_catalog_id"></a> [catalog\_id](#output\_catalog\_id) | The ID of the application template in Okta application catalog. |
| <a name="output_custom_error_page"></a> [custom\_error\_page](#output\_custom\_error\_page) | The URL for custom error page. |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether to enable the bookmark application. |
| <a name="output_group_assignments"></a> [group\_assignments](#output\_group\_assignments) | The information for the assigned groups to the application. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the bookmark application. |
| <a name="output_logo_url"></a> [logo\_url](#output\_logo\_url) | The URL of the application logo. |
| <a name="output_name"></a> [name](#output\_name) | The label of the bookmark application. |
| <a name="output_notes"></a> [notes](#output\_notes) | The configurations for application notes. |
| <a name="output_sign_on"></a> [sign\_on](#output\_sign\_on) | The configurations for application sign-on. |
| <a name="output_url"></a> [url](#output\_url) | The URL of the bookmark application. |
| <a name="output_user_assignments"></a> [user\_assignments](#output\_user\_assignments) | The information for the assigned users to the application. |
<!-- END_TF_DOCS -->
