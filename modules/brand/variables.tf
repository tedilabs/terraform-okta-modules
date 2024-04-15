variable "name" {
  description = "(Required) A name of the brand."
  type        = string
  nullable    = false
}

variable "locale" {
  description = "(Optional) The preferred language for the brand. Specified as an IETF BCP 47 language tag. Defaults to `en`."
  type        = string
  default     = "en"
  nullable    = false
}

variable "custom_privacy_policy" {
  description = <<EOF
  (Optional) A configurations for the custom privacy policy of the brand. `custom_privacy_policy` block as defined below.
    (Optional) `enabled` - Whether to use custom privacy policy. Defaults to `false`.
    (Optional) `url` - The url of the custom privacy policy.
  EOF
  type = object({
    enabled = optional(bool, false)
    url     = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = anytrue([
      !var.custom_privacy_policy.enabled,
      var.custom_privacy_policy.enabled && var.custom_privacy_policy.url != null
    ])
    error_message = "The value of `url` should be provided if the custom privacy policy is enabled."
  }
}

variable "powered_by_okta" {
  description = <<EOF
  (Optional) Whether "Powered by Okta" appears in any visible footers. Defaults to `false`.
  EOF
  type        = bool
  default     = false
  nullable    = false
}

variable "custom_domains" {
  description = <<EOF
  (Optional) A list of configurations for the custom domains. Each block of `custom_domains` block as defined below.
    (Required) `name` - The name of custom domain like `id.example.com`.
    (Optional) `type` - The certificate source type that indicates whether the certificate is provided by the user or Okta. Valid values are `MANUAL` and `OKTA_MANAGED`. Defaults to `OKTA_MANAGED`.
  EOF
  type = list(object({
    name = string
    type = optional(string, "OKTA_MANAGED")
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for domain in var.custom_domains :
      contains(["MANUAL", "OKTA_MANAGED"], domain.type)
    ])
    error_message = "Valid values for `type` are `MANUAL` and `OKTA_MANAGED`."
  }
}
