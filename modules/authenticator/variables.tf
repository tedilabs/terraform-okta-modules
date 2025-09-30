variable "name" {
  description = "(Required) A display name of the authenticator."
  type        = string
  nullable    = false
}

variable "type" {
  description = "(Required) A type of the MFA provider. Valid values are `CUSTOM_OTP`, `DUO`, `EXTERNAL_IDP`, `GOOGLE_OTP`, `OKTA_EMAIL`, `OKTA_PASSWORD`, `OKTA_VERIFY`, `ONPREM_MFA`, `PHONE_NUMBER`, `RSA_TOKEN`, `SECURITY_QUESTION`, or `WEBAUTHN`"
  type        = string
  nullable    = false

  validation {
    condition     = contains(["CUSTOM_OTP", "DUO", "EXTERNAL_IDP", "GOOGLE_OTP", "OKTA_EMAIL", "OKTA_PASSWORD", "OKTA_VERIFY", "ONPREM_MFA", "PHONE_NUMBER", "RSA_TOKEN", "SECURITY_QUESTION", "WEBAUTHN"], var.type)
    error_message = "Valid values for `type` are `CUSTOM_OTP`, `DUO`, `EXTERNAL_IDP`, `GOOGLE_OTP`, `OKTA_EMAIL`, `OKTA_PASSWORD`, `OKTA_VERIFY`, `ONPREM_MFA`, `PHONE_NUMBER`, `RSA_TOKEN`, `SECURITY_QUESTION`, or `WEBAUTHN`."
  }
}

variable "enabled" {
  description = "(Optional) Whether to activate the authenticator. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}
