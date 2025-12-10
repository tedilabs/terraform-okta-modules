variable "name" {
  description = "(Required) The label of the Okta OIDC application. The application's display name."
  type        = string
  nullable    = false
}

variable "type" {
  description = "(Required) The type of client application. Valid values are `browser`, `natvie`, `service`, `web`."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["browser", "native", "service", "web"], var.type)
    error_message = "Valid value for `type` is `browser`, `native`, `service`, or `web`."
  }
}

variable "logo_path" {
  description = "(Optional) A local file path to the logo. The file must be in PNG, JPG, or GIF format, and less than 1 MB in size."
  type        = string
  default     = null
  nullable    = true
}

variable "enabled" {
  description = "(Optional) Whether to enable the Okta saml application. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "grant_types" {
  description = <<EOF
  (Optional) A set of OAuth 2.0 grant types. Valid values are `authorization_code`, `client_credentials`, `implicit`, `interaction-code`, `password`, `refresh_token`. Defaults to `["authorization_code"]`.
  EOF
  type        = set(string)
  default     = ["authorization_code"]
  nullable    = false

  validation {
    condition = alltrue([
      for type in var.grant_types :
      contains(["authorization_code", "client_credentials", "implicit", "interaction-code", "password", "refresh_token"], type)
    ])
    error_message = "Valid values for `grant_types` are `authorization_code`, `client_credentials`, `implicit`, `interaction-code`, `password`, or `refresh_token`."
  }
}

variable "response_types" {
  description = <<EOF
  (Optional) A set of OAuth 2.0 response types. Valid values are any combination of: `code`, `id_token`, `none`, and `token`. Defaults to `["code"]`.
  EOF
  type        = set(string)
  default     = ["code"]
  nullable    = false

  validation {
    condition = alltrue([
      for type in var.response_types :
      contains(["code", "id_token", "none", "token"], type)
    ])
    error_message = "Valid values for `response_types` are `code`, `id_token`, `none`, or `token`."
  }
}

variable "client_authentication" {
  description = <<EOF
  (Optional) A configurations for client authentication. `client_authentication` block as defined below.
    (Optional) `method` - The requested authentication method for the token endpoint. Valid values are `client_secret_basic`, `client_secret_jwt`, `client_secret_post`, `none`, `private_key_jwt`. Defaults to `none`.
    (Optional) `client_id` - The OAuth client ID. If set during creation, app is created with this id.
    (Optional) `pkce_required` - Require Proof Key for Code Exchange (PKCE) for additional verification key rotation mode. Defaults to `true`.
  EOF
  type = object({
    method        = optional(string, "none")
    client_id     = optional(string)
    pkce_required = optional(bool, true)
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["client_secret_basic", "client_secret_jwt", "client_secret_post", "none", "private_key_jwt"], var.client_authentication.method)
    error_message = "Valid value for `client_authentication.method` is `client_secret_basic`, `client_secret_jwt`, `client_secret_post`, `none`, or `private_key_jwt`."
  }
}

variable "login" {
  description = <<EOF
  (Optional) A configurations for application login. `login` as defined below.
    (Required) `redirect_uris` - A set of redirect URIs for use in the redirect-based flow. This is required for all application types except `service`.
    (Optional) `post_logout_redirect_uris` - A set of post logout redirect URIs for redirection after logout.
    (Optional) `initiate_login_uri` - URI that initiates login.
    (Optional) `allow_wildcard_redirect` - Whether to allow wildcard redirect URIs. Defaults to `false`.
  EOF
  type = object({
    redirect_uris             = optional(set(string), [])
    post_logout_redirect_uris = optional(set(string), [])
    initiate_login_uri        = optional(string)
    allow_wildcard_redirect   = optional(bool, false)
  })
  default  = {}
  nullable = false
}

variable "oidc_id_token" {
  description = <<EOF
  (Optional) A configurations for OpenID Connect ID Token. `oidc_id_token` block as defined below.
    (Optional) `issuer_mode` - Whether the Okta Authorization Server uses the original Okta org domain URL or a custom domain URL as the issuer of ID token for this client. Valid values are `ORG_URL`, `CUSTOM_URL` or `DYNAMIC`. Defaults to `ORG_URL`.
    (Optional) `groups_claim_filter` - A configuration for filtering groups claim. `groups_claim_filter` block as defined below.
      (Required) `type` - The type of filter. Valid values are `STARTS_WITH`, `EQUALS`, `CONTAINS`, `REGEX`.
      (Required) `name` - A name of the claim that will be used in the token.
      (Required) `value` - A fliter value for the list of groups.
  EOF
  type = object({
    issuer_mode = optional(string, "ORG_URL")
    groups_claim_filter = optional(object({
      type  = string
      name  = string
      value = string
    }))
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["ORG_URL", "CUSTOM_URL", "DYNAMIC"], var.oidc_id_token.issuer_mode)
    error_message = "Valid value for `oidc_id_token.issuer_mode` is `ORG_URL`, `CUSTOM_URL` or `DYNAMIC`."
  }
  validation {
    condition     = var.oidc_id_token.groups_claim_filter == null || contains(["STARTS_WITH", "EQUALS", "CONTAINS", "REGEX"], var.oidc_id_token.groups_claim_filter.type)
    error_message = "Valid value for `oidc_id_token.groups_claim_filter.type` is `STARTS_WITH`, `EQUALS`, `CONTAINS`, or `REGEX`."
  }
}

variable "federation_broker_mode" {
  description = <<EOF
  (Optional) A configurations for Federation Broker Mode. `federation_broker_mode` block as defined below.
    (Optional) `enabled` - Whether to enable Federation Broker Mode. Improves app performance by granting access without the need to explicitly pre-assign your app to users. Access is managed by sign-on policies and any authorizationrules in your application. Defaults to `false`.
  EOF
  type = object({
    enabled = optional(bool, false)
  })
  default  = {}
  nullable = false
}

variable "user_consent" {
  description = <<EOF
  (Optional) A configurations for user consent of the OIDC application. `user_consent` block as defined below.
    (Optional) `method` - The method of user consent. Whether ruser consent is required or implicit. Valid values are `REQUIRED`, `TRUSTED`. Defaults to `TRUSTED`.
    (Optional) `logo_uri` - URI that references a logo for the client.
    (Optional) `policy_uri` - URI to web page providing client policy document.
    (Optional) `tos_uri` - URI to web page providing client tos (terms of service).
  EOF
  type = object({
    method     = optional(string, "TRUSTED")
    logo_uri   = optional(string)
    policy_uri = optional(string)
    tos_uri    = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["REQUIRED", "TRUSTED"], var.user_consent.method)
    error_message = "Valid value for `user_consent.method` is `REQUIRED` or `TRUSTED`."
  }
}

variable "sign_on" {
  description = <<EOF
  (Optional) A configurations for application sign-on. `sign_on` block as defined below.
    (Optional) `authentication_policy` - The ID of the authentication policy to associate to the applicatioauthentication policy to associate to the application. If this is removed from the application the default sign-on-policy will be associated with this application.
    (Optional) `user_name_template` - A configuration for the user name template. `user_name_template` block as defined below.
      (Optional) `type` - The type of user name template. Valid values are `BUILT_IN`, `CUSTOM` or `NONE`. Defaults to `BUILT_IN`.
      (Optional) `template` - The template for the user name. Defaults to `$${source.login}`.
      (Optional) `suffix` - The suffix to append to the user name. Only applicable if `type` is `BUILT_IN`. Defaults to an empty string.
      (Optional) `push_status` - The push status for the user name template. Valid values are `PUSH`, `DONT_PUSH` or `NOT_CONFIGURED`. Defaults to `PUSH`.
  EOF
  type = object({
    authentication_policy = optional(string)
    user_name_template = optional(object({
      type        = optional(string, "BUILT_IN")
      template    = optional(string, "$${source.login}")
      suffix      = optional(string, "")
      push_status = optional(string, "PUSH")
    }), {})
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["BUILT_IN", "CUSTOM", "NONE"], var.sign_on.user_name_template.type)
    error_message = "Valid value for `sign_on.user_name_template.type` is `BUILT_IN`, `CUSTOM`, or `NONE`."
  }
  validation {
    condition     = contains(["PUSH", "DONT_PUSH", "NOT_CONFIGURED"], var.sign_on.user_name_template.push_status)
    error_message = "Valid value for `sign_on.user_name_template.push_status` is `PUSH`, `DONT_PUSH`, or `NOT_CONFIGURED`."
  }
}

variable "notes" {
  description = <<EOF
  (Optional) A configurations for application notes. `notes` block as defined below.
    (Optional) `admin` - Application notes for admins.
    (Optional) `user` - Application notes for end users.
  EOF
  type = object({
    admin = optional(string, "")
    user  = optional(string, "")
  })
  default  = {}
  nullable = false
}

# variable "self_service" {
#   description = <<EOF
#   (Optional) Self-service configurations for the application. `self_service` block as defined below.
#     (Optional) `enabled` - Whether to enable self-service. Defaults to `false`.
#   EOF
#   type = object({
#     enabled = optional(bool, false)
#   })
#   default  = {}
#   nullable = false
# }
#
# variable "custom_error_page" {
#   description = "(Optional) The URL for custom error page."
#   type        = string
#   default     = null
#   nullable    = true
# }

variable "hide_app_on_ios" {
  description = "(Optional) Whether to hide application icon on mobile app. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "hide_app_on_web" {
  description = "(Optional) Whether to hide application icon on web. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "user_assignments" {
  description = <<EOF
  (Optional) A configurations to assign users for the Okta saml application. Each item of `user_assignments` block as defined below.
    (Required) `user` - The ID of the user to assign.
    (Optional) `profile` - JSON document containing application profile.
    (Optional) `username` - The username for the app user. In case the user is assigned to the app with SHARED_USERNAME_AND_PASSWORD credentials scheme, this field will be computed and should not be set.
    (Optional) `password` - The password for the app user.
  EOF
  type = list(object({
    user     = string
    profile  = optional(map(string), {})
    username = optional(string)
    password = optional(string)
  }))
  default  = []
  nullable = false
}

variable "group_assignments" {
  description = <<EOF
  (Optional) A configurations to assign groups for the Okta saml application. Each item of `group_assignments` block as defined below.
    (Required) `group` - The ID of the group to assign.
    (Optional) `priority` - A priority of group assignment
    (Optional) `profile` - JSON document containing application profile.
  EOF
  type = list(object({
    group    = string
    priority = optional(number)
    profile  = optional(map(string), {})
  }))
  default  = []
  nullable = false
}
