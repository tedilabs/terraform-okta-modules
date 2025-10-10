variable "name" {
  description = "(Required) The label of the Okta saml application. The application's display name."
  type        = string
  nullable    = false
}

variable "preconfigured_app" {
  description = "(Optional) The name of a preconfigured app from the Okta App Integration Network. For example `aws_sso`, `google`, `github_enterprise`, etc. When this is specified, most SAML configuration is inherited from the preconfigured app."
  type        = string
  default     = null
  nullable    = true
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

variable "app_settings" {
  description = <<EOF
  (Optional) A configuration for application settings. The structure of this object varies by application. If `preconfigured_app` is set, this can be left empty to use the default settings for the preconfigured app. See the [Okta App Integration Network](https://developer.okta.com/docs/reference/app-integration-network/) for more details on the settings for each preconfigured app.
  EOF
  type        = any
  default     = null
  nullable    = true
}

variable "saml_attributes" {
  description = <<EOF
  (Optional) A list of SAML attribute statements for the application. Each item of `saml_attributes` block as defined below.
    (Required) `name` - The name of the attribute.
    (Optional) `namespace` - The namespace for the attribute. Valid values are `urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified`, `urn:oasis:names:tc:SAML:2.0:attrname-format:uri`, `urn:oasis:names:tc:SAML:2.0:attrname-format:basic`. Defaults to `urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified`.
    (Optional) `type` - The type of the attribute. Valid values are `EXPRESSION`, `GROUP`.
    (Optional) `values` - The values for the attribute.
    (Optional) `filter` - A filter configuration for group attributes. Only requirded if `type` is `GROUP`. `filter` block as defined below.
      (Required) `type` - The filter type for group attributes. Valid values are `REGEX`, `STARTS_WITH`, `EQUALS`, `CONTAINS`.
      (Required) `value` - The filter value for group attributes.
  EOF
  type = list(object({
    type      = optional(string, "EXPRESSION")
    namespace = optional(string, "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified")
    name      = string
    values    = optional(list(string))
    filter = optional(object({
      type  = string
      value = string
    }))
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for attribute in var.saml_attributes :
      contains(["EXPRESSION", "GROUP"], attribute.type)
    ])
    error_message = "Valid value for `type` is `EXPRESSION` or `GROUP`."
  }
  validation {
    condition = alltrue([
      for attribute in var.saml_attributes :
      contains(["urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified", "urn:oasis:names:tc:SAML:2.0:attrname-format:uri", "urn:oasis:names:tc:SAML:2.0:attrname-format:basic"], attribute.namespace)
    ])
    error_message = "Valid value for `namespace` is `urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified`, `urn:oasis:names:tc:SAML:2.0:attrname-format:uri`, or `urn:oasis:names:tc:SAML:2.0:attrname-format:basic`."
  }
}

variable "single_logout" {
  description = <<EOF
  (Optional) Single logout configuration for the application. `single_logout` block as defined below.
    (Optional) `issuer` - The issuer of the Service Provider that generates the Single Logout request.
    (Optional) `url` - The URL where the logout response is sent.
    (Optional) `certificate` - The X509 encoded certificate that the Service Provider uses to sign Single Logout requests. Note: should be provided without `-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----`.
  EOF
  type = object({
    issuer      = optional(string)
    url         = optional(string)
    certificate = optional(string)
  })
  default  = {}
  nullable = false
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

variable "self_service" {
  description = <<EOF
  (Optional) Self-service configurations for the application. `self_service` block as defined below.
    (Optional) `enabled` - Whether to enable self-service. Defaults to `false`.
  EOF
  type = object({
    enabled = optional(bool, false)
  })
  default  = {}
  nullable = false
}

variable "custom_error_page" {
  description = "(Optional) The URL for custom error page."
  type        = string
  default     = null
  nullable    = true
}

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
