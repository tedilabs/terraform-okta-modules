variable "type" {
  description = "(Required) A type of the MFA provider. Valid values are `DUO`, `FIDO_U2F`, `FIDO_WEBAUTHN`, `GOOGLE_OTP`, `OKTA_CALL`, `OKTA_OTP`, `OKTA_PASSWORD`, `OKTA_PUSH`, `OKTA_QUESTION`, `OKTA_SMS`, `OKTA_EMAIL`, `RSA_TOKEN`, `SYMANTEC_VIP`, `YUBIKEY_TOKEN`, or `HOTP`"
  type        = string
  nullable    = false

  validation {
    condition     = contains(["DUO", "FIDO_U2F", "FIDO_WEBAUTHN", "GOOGLE_OTP", "OKTA_CALL", "OKTA_OTP", "OKTA_PASSWORD", "OKTA_PUSH", "OKTA_QUESTION", "OKTA_SMS", "OKTA_EMAIL", "RSA_TOKEN", "SYMANTEC_VIP", "YUBIKEY_TOKEN", "HOTP"], var.type)
    error_message = "Valid values for `type` are `DUO`, `FIDO_U2F`, `FIDO_WEBAUTHN`, `GOOGLE_OTP`, `OKTA_CALL`, `OKTA_OTP`, `OKTA_PASSWORD`, `OKTA_PUSH`, `OKTA_QUESTION`, `OKTA_SMS`, `OKTA_EMAIL`, `RSA_TOKEN`, `SYMANTEC_VIP`, `YUBIKEY_TOKEN`, or `HOTP`."
  }
}

variable "enabled" {
  description = "(Optional) Whether to activate the authenticator. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}
