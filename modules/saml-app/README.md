# saml-app

This module creates following resources.

- `okta_app_saml`
- `okta_app_saml_app_settings` (optional)
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
| [okta_app_group_assignments.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_group_assignments) | resource |
| [okta_app_saml.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_saml) | resource |
| [okta_app_saml_app_settings.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_saml_app_settings) | resource |
| [okta_app_user.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_user) | resource |
| [okta_group.this](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/group) | data source |
| [okta_user.this](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The label of the Okta saml application. The application's display name. | `string` | n/a | yes |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | (Optional) A configuration for application settings. The structure of this object varies by application. If `preconfigured_app` is set, this can be left empty to use the default settings for the preconfigured app. See the [Okta App Integration Network](https://developer.okta.com/docs/reference/app-integration-network/) for more details on the settings for each preconfigured app. | `any` | `null` | no |
| <a name="input_custom_error_page"></a> [custom\_error\_page](#input\_custom\_error\_page) | (Optional) The URL for custom error page. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether to enable the Okta saml application. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_group_assignments"></a> [group\_assignments](#input\_group\_assignments) | (Optional) A configurations to assign groups for the Okta saml application. Each item of `group_assignments` block as defined below.<br/>    (Required) `group` - The ID of the group to assign.<br/>    (Optional) `priority` - A priority of group assignment<br/>    (Optional) `profile` - JSON document containing application profile. | <pre>list(object({<br/>    group    = string<br/>    priority = optional(number)<br/>    profile  = optional(map(string), {})<br/>  }))</pre> | `[]` | no |
| <a name="input_hide_app_on_ios"></a> [hide\_app\_on\_ios](#input\_hide\_app\_on\_ios) | (Optional) Whether to hide application icon on mobile app. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_hide_app_on_web"></a> [hide\_app\_on\_web](#input\_hide\_app\_on\_web) | (Optional) Whether to hide application icon on web. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_logo_path"></a> [logo\_path](#input\_logo\_path) | (Optional) A local file path to the logo. The file must be in PNG, JPG, or GIF format, and less than 1 MB in size. | `string` | `null` | no |
| <a name="input_notes"></a> [notes](#input\_notes) | (Optional) A configurations for application notes. `notes` block as defined below.<br/>    (Optional) `admin` - Application notes for admins.<br/>    (Optional) `user` - Application notes for end users. | <pre>object({<br/>    admin = optional(string, "")<br/>    user  = optional(string, "")<br/>  })</pre> | `{}` | no |
| <a name="input_preconfigured_app"></a> [preconfigured\_app](#input\_preconfigured\_app) | (Optional) The name of a preconfigured app from the Okta App Integration Network. For example `aws_sso`, `google`, `github_enterprise`, etc. When this is specified, most SAML configuration is inherited from the preconfigured app. | `string` | `null` | no |
| <a name="input_saml_attributes"></a> [saml\_attributes](#input\_saml\_attributes) | (Optional) A list of SAML attribute statements for the application. Each item of `saml_attributes` block as defined below.<br/>    (Required) `name` - The name of the attribute.<br/>    (Optional) `namespace` - The namespace for the attribute. Valid values are `urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified`, `urn:oasis:names:tc:SAML:2.0:attrname-format:uri`, `urn:oasis:names:tc:SAML:2.0:attrname-format:basic`. Defaults to `urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified`.<br/>    (Optional) `type` - The type of the attribute. Valid values are `EXPRESSION`, `GROUP`.<br/>    (Optional) `values` - The values for the attribute.<br/>    (Optional) `filter` - A filter configuration for group attributes. Only requirded if `type` is `GROUP`. `filter` block as defined below.<br/>      (Required) `type` - The filter type for group attributes. Valid values are `REGEX`, `STARTS_WITH`, `EQUALS`, `CONTAINS`.<br/>      (Required) `value` - The filter value for group attributes. | <pre>list(object({<br/>    type      = optional(string, "EXPRESSION")<br/>    namespace = optional(string, "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified")<br/>    name      = string<br/>    values    = optional(list(string))<br/>    filter = optional(object({<br/>      type  = string<br/>      value = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_self_service"></a> [self\_service](#input\_self\_service) | (Optional) Self-service configurations for the application. `self_service` block as defined below.<br/>    (Optional) `enabled` - Whether to enable self-service. Defaults to `false`. | <pre>object({<br/>    enabled = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_sign_on"></a> [sign\_on](#input\_sign\_on) | (Optional) A configurations for application sign-on. `sign_on` block as defined below.<br/>    (Optional) `authentication_policy` - The ID of the authentication policy to associate to the applicatioauthentication policy to associate to the application. If this is removed from the application the default sign-on-policy will be associated with this application.<br/>    (Optional) `user_name_template` - A configuration for the user name template. `user_name_template` block as defined below.<br/>      (Optional) `type` - The type of user name template. Valid values are `BUILT_IN`, `CUSTOM` or `NONE`. Defaults to `BUILT_IN`.<br/>      (Optional) `template` - The template for the user name. Defaults to `${source.login}`.<br/>      (Optional) `suffix` - The suffix to append to the user name. Only applicable if `type` is `BUILT_IN`. Defaults to an empty string.<br/>      (Optional) `push_status` - The push status for the user name template. Valid values are `PUSH`, `DONT_PUSH` or `NOT_CONFIGURED`. Defaults to `PUSH`. | <pre>object({<br/>    authentication_policy = optional(string)<br/>    user_name_template = optional(object({<br/>      type        = optional(string, "BUILT_IN")<br/>      template    = optional(string, "$${source.login}")<br/>      suffix      = optional(string, "")<br/>      push_status = optional(string, "PUSH")<br/>    }), {})<br/>  })</pre> | `{}` | no |
| <a name="input_single_logout"></a> [single\_logout](#input\_single\_logout) | (Optional) Single logout configuration for the application. `single_logout` block as defined below.<br/>    (Optional) `issuer` - The issuer of the Service Provider that generates the Single Logout request.<br/>    (Optional) `url` - The URL where the logout response is sent.<br/>    (Optional) `certificate` - The X509 encoded certificate that the Service Provider uses to sign Single Logout requests. Note: should be provided without `-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----`. | <pre>object({<br/>    issuer      = optional(string)<br/>    url         = optional(string)<br/>    certificate = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_user_assignments"></a> [user\_assignments](#input\_user\_assignments) | (Optional) A configurations to assign users for the Okta saml application. Each item of `user_assignments` block as defined below.<br/>    (Required) `user` - The ID of the user to assign.<br/>    (Optional) `profile` - JSON document containing application profile.<br/>    (Optional) `username` - The username for the app user. In case the user is assigned to the app with SHARED\_USERNAME\_AND\_PASSWORD credentials scheme, this field will be computed and should not be set.<br/>    (Optional) `password` - The password for the app user. | <pre>list(object({<br/>    user     = string<br/>    profile  = optional(map(string), {})<br/>    username = optional(string)<br/>    password = optional(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_links"></a> [app\_links](#output\_app\_links) | The application links for the SAML application. |
| <a name="output_app_settings"></a> [app\_settings](#output\_app\_settings) | The application settings. |
| <a name="output_catalog_id"></a> [catalog\_id](#output\_catalog\_id) | The ID of the application template in Okta application catalog. |
| <a name="output_custom_error_page"></a> [custom\_error\_page](#output\_custom\_error\_page) | The URL for custom error page. |
| <a name="output_embed_url"></a> [embed\_url](#output\_embed\_url) | The embed URL of the SAML application. |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether to enable the SAML application. |
| <a name="output_features"></a> [features](#output\_features) | The features enabled for the SAML application. |
| <a name="output_group_assignments"></a> [group\_assignments](#output\_group\_assignments) | The information for the assigned groups to the application. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the SAML application. |
| <a name="output_logo_url"></a> [logo\_url](#output\_logo\_url) | The URL of the application logo. |
| <a name="output_name"></a> [name](#output\_name) | The label of the SAML application. |
| <a name="output_notes"></a> [notes](#output\_notes) | The configurations for application notes. |
| <a name="output_preconfigured_app"></a> [preconfigured\_app](#output\_preconfigured\_app) | The name of a preconfigured app from the Okta App Integration Network. |
| <a name="output_saml_attributes"></a> [saml\_attributes](#output\_saml\_attributes) | A list of SAML attribute statements for the application. |
| <a name="output_saml_metadata"></a> [saml\_metadata](#output\_saml\_metadata) | The SAML metadata configurations. |
| <a name="output_saml_version"></a> [saml\_version](#output\_saml\_version) | The SAML version used by the application. |
| <a name="output_sign_on"></a> [sign\_on](#output\_sign\_on) | The configurations for application sign-on. |
| <a name="output_single_logout"></a> [single\_logout](#output\_single\_logout) | The configurations for single logout. |
| <a name="output_user_assignments"></a> [user\_assignments](#output\_user\_assignments) | The information for the assigned users to the application. |
<!-- END_TF_DOCS -->
