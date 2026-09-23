variable "name" {
  description = "(Required) A name of the authorization server."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) A description of the authorization server. Defaults to `Managed by Terraform.`"
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "enabled" {
  description = "(Optional) Whether to activate the authorization server. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "audiences" {
  description = "(Required) A set of recipients that the tokens are intended for. This becomes the aud claim in an access token. Currently Okta only supports a single value here."
  type        = set(string)
  nullable    = false

  validation {
    condition     = length(var.audiences) >= 1
    error_message = "The audiences set must contain at least one value."
  }
}

variable "issuer" {
  description = <<EOF
  (Optional) A configuration for issuer of the authorization server. `issuer` block as defined below.
    (Optional) `mode` - The issuer mode of the authorization server. Valid values are `ORG_URL`, `CUSTOM_URL` and `DYNAMIC`. Defaults to `DYNAMIC`.
  EOF
  type = object({
    mode = optional(string, "DYNAMIC")
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["ORG_URL", "CUSTOM_URL", "DYNAMIC"], var.issuer.mode)
    error_message = "Valid value for `issuer.mode` must be one of `ORG_URL`, `CUSTOM_URL`, or `DYNAMIC`."
  }
}

variable "signing_key" {
  description = <<EOF
  (Optional) A signing key configuration of the authorization server. `signing_key` block as defined below.
    (Optional) `rotation_mode` - The signing key rotation mode of the authorization server. Valid values are `MANUAL` and `AUTO`. Defaults to `AUTO`.
  EOF
  type = object({
    rotation_mode = optional(string, "AUTO")
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["MANUAL", "AUTO"], var.signing_key.rotation_mode)
    error_message = "Valid value for `signing_key.rotation_mode` is `MANUAL` or `AUTO`."
  }
}

variable "claims" {
  description = <<EOF
  (Optional) A list of claims to be created for the authorization server. Each block of `claims` as defined below.
    (Required) `token_type` - The token type of the claim. Valid values are `ID_TOKEN`, `ACCESS_TOKEN`.
    (Optional) `always_include_in_token` - Whether to always include the claim in the token. Defaults to `true`.
    (Required) `name` - The name of the claim.
    (Optional) `value_type` - The value type of the claim. Valid values are `EXPRESSIONS` and `GROUPS`. Defaults to `EXPRESSION`.
    (Optional) `operator` - The operator of group filter if `value_type` is `GROUPS`. Valid values are `STARTS_WITH`, `EQUALS`, `CONTAINS`, `REGEX`. Defaults to `REGEX`.
    (Required) `value` - The value of the claim.
    (Optional) `enabled` - Whether the claim is enabled. Defaults to `true`.
    (Optional) `scopes` - A set of scope names the auth server claim is tied to.

  EOF
  type = list(object({
    token_type              = string
    always_include_in_token = optional(bool, true)

    name       = string
    value_type = optional(string, "EXPRESSION")
    operator   = optional(string, "REGEX")
    value      = string

    enabled = optional(bool, true)
    scopes  = optional(set(string), [])
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for claim in var.claims : contains(["ID_TOKEN", "ACCESS_TOKEN"], claim.token_type)
    ])
    error_message = "Valid value for `token_type` is `ID_TOKEN` or `ACCESS_TOKEN`."
  }
  validation {
    condition = alltrue([
      for claim in var.claims : contains(["EXPRESSION", "GROUPS"], claim.value_type)
    ])
    error_message = "Valid value for `value_type` is `EXPRESSION` or `GROUPS`."
  }
  validation {
    condition = alltrue([
      for claim in var.claims :
      contains(["STARTS_WITH", "EQUALS", "CONTAINS", "REGEX"], claim.operator)
      if claim.value_type == "GROUPS"
    ])
    error_message = "Valid value for `operator` is `STARTS_WITH`, `EQUALS`, `CONTAINS`, or `REGEX` when `value_type` is `GROUPS`."
  }
}

variable "access_policies" {
  description = <<EOF
  (Optional) A list of access policies to be created for the authorization server. Each block of `access_policies` as defined below.
    (Optional) `priority` - A priority of the access policy.
    (Required) `name` - A name of the access policy.
    (Optional) `description` - A description of the access policy. Defaults to `Managed by Terraform.`
    (Optional) `enabled` - Whether to enable the access policy. Defaults to `true`.
    (Optional) `assigned_clients` - A set of client IDs to be assigned to the access policy. `["ALL_CLIENTS"]` is a special value that can be used to whitelist all clients.
    (Optional) `rules` - A configuration for rules of the access policy. Each item of `rules` block as defined below.
      (Required) `name` - A name of the access policy rule. Must be unique within the access policy.
      (Optional) `priority` - A priority of the access policy rule. Defaults to the position of the rule in `rules`, starting from `1`.
      (Optional) `enabled` - Whether to enable the access policy rule. Defaults to `true`.
      (Optional) `condition` - A condition of the access policy rule. `condition` block as defined below.
        (Required) `grant_types` - A set of grant types to accept. Valid values are `authorization_code`, `client_credentials`, `implicit`, `interaction_code`, `password`, `urn:ietf:params:oauth:grant-type:device_code`, `urn:ietf:params:oauth:grant-type:saml2-bearer`, `urn:ietf:params:oauth:grant-type:token-exchange`.
        (Optional) `scopes` - A set of scope names allowed for this rule. `["*"]` is a special value that allows all scopes. Defaults to `["*"]`.
        (Optional) `included_users` - A set of user IDs to include.
        (Optional) `excluded_users` - A set of user IDs to exclude.
        (Optional) `included_groups` - A set of group IDs to include. `["EVERYONE"]` is a special value that includes every user assigned to the application. Defaults to `["EVERYONE"]`.
        (Optional) `excluded_groups` - A set of group IDs to exclude.
      (Optional) `access_token` - A configuration for the access token issued by the access policy rule. `access_token` block as defined below.
        (Optional) `lifetime` - A lifetime of the access token in minutes. Okta accepts a value from `5` to `1440`. Defaults to `60` (1 hour).
      (Optional) `refresh_token` - A configuration for the refresh token issued by the access policy rule. `refresh_token` block as defined below.
        (Optional) `lifetime` - A lifetime of the refresh token in minutes. `0` means the refresh token never expires on its own, so its usable life is bounded by `window`. Defaults to `0`.
        (Optional) `window` - A window in which the refresh token can be used in minutes. Okta accepts a value from `5` to `2628000` (5 years). Must be between `access_token.lifetime` and `refresh_token.lifetime` unless `refresh_token.lifetime` is `0`. Defaults to `10080` (7 days).
      (Optional) `inline_hook` - The ID of the inline token hook to trigger.
  EOF
  type = list(object({
    priority         = optional(number)
    name             = string
    description      = optional(string, "Managed by Terraform.")
    enabled          = optional(bool, true)
    assigned_clients = optional(set(string), [])

    rules = optional(list(object({
      name     = string
      priority = optional(number)
      enabled  = optional(bool, true)

      condition = object({
        grant_types = set(string)
        scopes      = optional(set(string), ["*"])

        included_users  = optional(set(string), [])
        excluded_users  = optional(set(string), [])
        included_groups = optional(set(string), ["EVERYONE"])
        excluded_groups = optional(set(string), [])
      })

      access_token = optional(object({
        lifetime = optional(number, 60)
      }), {})
      refresh_token = optional(object({
        lifetime = optional(number, 0)
        window   = optional(number, 60 * 24 * 7)
      }), {})

      inline_hook = optional(string)
    })), [])
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue(flatten([
      for policy in var.access_policies : [
        for rule in policy.rules : [
          for grant_type in rule.condition.grant_types :
          contains([
            "authorization_code",
            "client_credentials",
            "implicit",
            "interaction_code",
            "password",
            "urn:ietf:params:oauth:grant-type:device_code",
            "urn:ietf:params:oauth:grant-type:saml2-bearer",
            "urn:ietf:params:oauth:grant-type:token-exchange",
          ], grant_type)
        ]
      ]
    ]))
    error_message = "Valid values for `rules.condition.grant_types` are `authorization_code`, `client_credentials`, `implicit`, `interaction_code`, `password`, `urn:ietf:params:oauth:grant-type:device_code`, `urn:ietf:params:oauth:grant-type:saml2-bearer`, or `urn:ietf:params:oauth:grant-type:token-exchange`."
  }
  validation {
    condition = alltrue(flatten([
      for policy in var.access_policies : [
        for rule in policy.rules :
        rule.access_token.lifetime >= 5 && rule.access_token.lifetime <= 1440
      ]
    ]))
    error_message = "Valid value for `rules.access_token.lifetime` is between `5` and `1440`."
  }
  validation {
    condition = alltrue(flatten([
      for policy in var.access_policies : [
        for rule in policy.rules :
        rule.refresh_token.window >= 5 && rule.refresh_token.window <= 2628000
      ]
    ]))
    error_message = "Valid value for `rules.refresh_token.window` is between `5` and `2628000`."
  }
  validation {
    condition = alltrue([
      for policy in var.access_policies :
      length(policy.rules) == length(distinct([
        for rule in policy.rules :
        rule.name
      ]))
    ])
    error_message = "Each item of `rules.name` must be unique within the access policy."
  }
}
