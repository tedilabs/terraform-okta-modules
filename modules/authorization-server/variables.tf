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
