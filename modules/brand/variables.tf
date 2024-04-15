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
