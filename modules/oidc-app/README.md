# oidc-app

This module creates following resources.

- `okta_app_oauth`
- `okta_app_oauth_api_scope` (optional)
- `okta_app_oauth_role_assignment` (optional)
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
| [okta_app_oauth.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_oauth) | resource |
| [okta_app_user.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_user) | resource |
| [okta_group.this](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/group) | data source |
| [okta_user.this](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The label of the Okta OIDC application. The application's display name. | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | (Required) The type of client application. Valid values are `browser`, `natvie`, `service`, `web`. | `string` | n/a | yes |
| <a name="input_client_authentication"></a> [client\_authentication](#input\_client\_authentication) | (Optional) A configurations for client authentication. `client_authentication` block as defined below.<br/>    (Optional) `method` - The requested authentication method for the token endpoint. Valid values are `client_secret_basic`, `client_secret_jwt`, `client_secret_post`, `none`, `private_key_jwt`. Defaults to `none`.<br/>    (Optional) `client_id` - The OAuth client ID. If set during creation, app is created with this id.<br/>    (Optional) `pkce_required` - Require Proof Key for Code Exchange (PKCE) for additional verification key rotation mode. Defaults to `true`. | <pre>object({<br/>    method        = optional(string, "none")<br/>    client_id     = optional(string)<br/>    pkce_required = optional(bool, true)<br/>  })</pre> | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether to enable the Okta saml application. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_federation_broker_mode"></a> [federation\_broker\_mode](#input\_federation\_broker\_mode) | (Optional) A configurations for Federation Broker Mode. `federation_broker_mode` block as defined below.<br/>    (Optional) `enabled` - Whether to enable Federation Broker Mode. Improves app performance by granting access without the need to explicitly pre-assign your app to users. Access is managed by sign-on policies and any authorizationrules in your application. Defaults to `false`. | <pre>object({<br/>    enabled = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_grant_types"></a> [grant\_types](#input\_grant\_types) | (Optional) A set of OAuth 2.0 grant types. Valid values are `authorization_code`, `client_credentials`, `implicit`, `interaction-code`, `password`, `refresh_token`. Defaults to `["authorization_code"]`. | `set(string)` | <pre>[<br/>  "authorization_code"<br/>]</pre> | no |
| <a name="input_group_assignments"></a> [group\_assignments](#input\_group\_assignments) | (Optional) A configurations to assign groups for the Okta saml application. Each item of `group_assignments` block as defined below.<br/>    (Required) `group` - The ID of the group to assign.<br/>    (Optional) `priority` - A priority of group assignment<br/>    (Optional) `profile` - JSON document containing application profile. | <pre>list(object({<br/>    group    = string<br/>    priority = optional(number)<br/>    profile  = optional(map(string), {})<br/>  }))</pre> | `[]` | no |
| <a name="input_hide_app_on_ios"></a> [hide\_app\_on\_ios](#input\_hide\_app\_on\_ios) | (Optional) Whether to hide application icon on mobile app. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_hide_app_on_web"></a> [hide\_app\_on\_web](#input\_hide\_app\_on\_web) | (Optional) Whether to hide application icon on web. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_login"></a> [login](#input\_login) | (Optional) A configurations for application login. `login` as defined below.<br/>    (Required) `redirect_uris` - A set of redirect URIs for use in the redirect-based flow. This is required for all application types except `service`.<br/>    (Optional) `post_logout_redirect_uris` - A set of post logout redirect URIs for redirection after logout.<br/>    (Optional) `initiate_login_uri` - URI that initiates login.<br/>    (Optional) `allow_wildcard_redirect` - Whether to allow wildcard redirect URIs. Defaults to `false`. | <pre>object({<br/>    redirect_uris             = optional(set(string), [])<br/>    post_logout_redirect_uris = optional(set(string), [])<br/>    initiate_login_uri        = optional(string)<br/>    allow_wildcard_redirect   = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_logo_path"></a> [logo\_path](#input\_logo\_path) | (Optional) A local file path to the logo. The file must be in PNG, JPG, or GIF format, and less than 1 MB in size. | `string` | `null` | no |
| <a name="input_notes"></a> [notes](#input\_notes) | (Optional) A configurations for application notes. `notes` block as defined below.<br/>    (Optional) `admin` - Application notes for admins.<br/>    (Optional) `user` - Application notes for end users. | <pre>object({<br/>    admin = optional(string, "")<br/>    user  = optional(string, "")<br/>  })</pre> | `{}` | no |
| <a name="input_oidc_id_token"></a> [oidc\_id\_token](#input\_oidc\_id\_token) | (Optional) A configurations for OpenID Connect ID Token. `oidc_id_token` block as defined below.<br/>    (Optional) `issuer_mode` - Whether the Okta Authorization Server uses the original Okta org domain URL or a custom domain URL as the issuer of ID token for this client. Valid values are `ORG_URL` or `CUSTOM_URL`. Defaults to `ORG_URL`.<br/>    (Optional) `groups_claim_filter` - A configuration for filtering groups claim. `groups_claim_filter` block as defined below.<br/>      (Required) `type` - The type of filter. Valid values are `STARTS_WITH`, `EQUALS`, `CONTAINS`, `REGEX`.<br/>      (Required) `name` - A name of the claim that will be used in the token.<br/>      (Required) `value` - A fliter value for the list of groups. | <pre>object({<br/>    issuer_mode = optional(string, "ORG_URL")<br/>    groups_claim_filter = optional(object({<br/>      type  = string<br/>      name  = string<br/>      value = string<br/>    }))<br/>  })</pre> | `{}` | no |
| <a name="input_response_types"></a> [response\_types](#input\_response\_types) | (Optional) A set of OAuth 2.0 response types. Valid values are any combination of: `code`, `id_token`, `none`, and `token`. Defaults to `["code"]`. | `set(string)` | <pre>[<br/>  "code"<br/>]</pre> | no |
| <a name="input_sign_on"></a> [sign\_on](#input\_sign\_on) | (Optional) A configurations for application sign-on. `sign_on` block as defined below.<br/>    (Optional) `authentication_policy` - The ID of the authentication policy to associate to the applicatioauthentication policy to associate to the application. If this is removed from the application the default sign-on-policy will be associated with this application.<br/>    (Optional) `user_name_template` - A configuration for the user name template. `user_name_template` block as defined below.<br/>      (Optional) `type` - The type of user name template. Valid values are `BUILT_IN`, `CUSTOM` or `NONE`. Defaults to `BUILT_IN`.<br/>      (Optional) `template` - The template for the user name. Defaults to `${source.login}`.<br/>      (Optional) `suffix` - The suffix to append to the user name. Only applicable if `type` is `BUILT_IN`. Defaults to an empty string.<br/>      (Optional) `push_status` - The push status for the user name template. Valid values are `PUSH`, `DONT_PUSH` or `NOT_CONFIGURED`. Defaults to `PUSH`. | <pre>object({<br/>    authentication_policy = optional(string)<br/>    user_name_template = optional(object({<br/>      type        = optional(string, "BUILT_IN")<br/>      template    = optional(string, "$${source.login}")<br/>      suffix      = optional(string, "")<br/>      push_status = optional(string, "PUSH")<br/>    }), {})<br/>  })</pre> | `{}` | no |
| <a name="input_user_assignments"></a> [user\_assignments](#input\_user\_assignments) | (Optional) A configurations to assign users for the Okta saml application. Each item of `user_assignments` block as defined below.<br/>    (Required) `user` - The ID of the user to assign.<br/>    (Optional) `profile` - JSON document containing application profile.<br/>    (Optional) `username` - The username for the app user. In case the user is assigned to the app with SHARED\_USERNAME\_AND\_PASSWORD credentials scheme, this field will be computed and should not be set.<br/>    (Optional) `password` - The password for the app user. | <pre>list(object({<br/>    user     = string<br/>    profile  = optional(map(string), {})<br/>    username = optional(string)<br/>    password = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_user_consent"></a> [user\_consent](#input\_user\_consent) | (Optional) A configurations for user consent of the OIDC application. `user_consent` block as defined below.<br/>    (Optional) `method` - The method of user consent. Whether ruser consent is required or implicit. Valid values are `REQUIRED`, `TRUSTED`. Defaults to `TRUSTED`.<br/>    (Optional) `logo_uri` - URI that references a logo for the client.<br/>    (Optional) `policy_uri` - URI to web page providing client policy document.<br/>    (Optional) `tos_uri` - URI to web page providing client tos (terms of service). | <pre>object({<br/>    method     = optional(string, "TRUSTED")<br/>    logo_uri   = optional(string)<br/>    policy_uri = optional(string)<br/>    tos_uri    = optional(string)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_authentication"></a> [client\_authentication](#output\_client\_authentication) | The client authentication method for the OIDC application. |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether to enable the OIDC application. |
| <a name="output_federation_broker_mode"></a> [federation\_broker\_mode](#output\_federation\_broker\_mode) | The configuration for federation broker mode. |
| <a name="output_grant_types"></a> [grant\_types](#output\_grant\_types) | The OAuth 2.0 grant types supported by the OIDC application. |
| <a name="output_group_assignments"></a> [group\_assignments](#output\_group\_assignments) | The information for the assigned groups to the application. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the OIDC application. |
| <a name="output_login"></a> [login](#output\_login) | The configurations for application login. |
| <a name="output_logo_url"></a> [logo\_url](#output\_logo\_url) | The URL of the application logo. |
| <a name="output_name"></a> [name](#output\_name) | The label of the OIDC application. |
| <a name="output_notes"></a> [notes](#output\_notes) | The configurations for application notes. |
| <a name="output_oidc_id_token"></a> [oidc\_id\_token](#output\_oidc\_id\_token) | The configurations for OIDC ID token. |
| <a name="output_response_types"></a> [response\_types](#output\_response\_types) | The OAuth 2.0 response types supported by the OIDC application. |
| <a name="output_sign_on"></a> [sign\_on](#output\_sign\_on) | The configurations for application sign-on. |
| <a name="output_type"></a> [type](#output\_type) | The type of the OIDC application. |
| <a name="output_user_assignments"></a> [user\_assignments](#output\_user\_assignments) | The information for the assigned users to the application. |
| <a name="output_user_consent"></a> [user\_consent](#output\_user\_consent) | The configurations for user consent of the OIDC application. |
<!-- END_TF_DOCS -->
