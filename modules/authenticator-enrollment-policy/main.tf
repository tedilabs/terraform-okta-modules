locals {
  is_default = var.name == "default"

  policy = (local.is_default
    ? merge(okta_policy_mfa_default.this[0], {
    })
    : okta_policy_mfa.this[0]
  )
}


###################################################
# Okta Authenticator Enrollment Policy
###################################################

# INFO: Not supported attributes
# - `external_idp`
resource "okta_policy_mfa" "this" {
  count = local.is_default ? 0 : 1

  name        = var.name
  description = var.description
  status      = var.enabled ? "ACTIVE" : "INACTIVE"
  is_oie      = true

  priority        = var.priority
  groups_included = var.groups


  ## Authenticators
  google_otp = {
    enroll = (contains(var.required_authenticators, "GOOGLE_OTP")
      ? "REQUIRED"
      : (contains(var.optional_authenticators, "GOOGLE_OTP")
        ? "OPTIONAL"
        : null
      )
    )
  }

  okta_email = {
    enroll = (contains(var.required_authenticators, "OKTA_EMAIL")
      ? "REQUIRED"
      : (contains(var.optional_authenticators, "OKTA_EMAIL")
        ? "OPTIONAL"
        : null
      )
    )
  }

  okta_password = {
    enroll = (contains(var.required_authenticators, "OKTA_PASSWORD")
      ? "REQUIRED"
      : (contains(var.optional_authenticators, "OKTA_PASSWORD")
        ? "OPTIONAL"
        : null
      )
    )
  }

  okta_verify = {
    enroll = (contains(var.required_authenticators, "OKTA_VERIFY")
      ? "REQUIRED"
      : (contains(var.optional_authenticators, "OKTA_VERIFY")
        ? "OPTIONAL"
        : null
      )
    )
  }

  phone_number = {
    enroll = (contains(var.required_authenticators, "PHONE_NUMBER")
      ? "REQUIRED"
      : (contains(var.optional_authenticators, "PHONE_NUMBER")
        ? "OPTIONAL"
        : null
      )
    )
  }

  security_question = {
    enroll = (contains(var.required_authenticators, "SECURITY_QUESTION")
      ? "REQUIRED"
      : (contains(var.optional_authenticators, "SECURITY_QUESTION")
        ? "OPTIONAL"
        : null
      )
    )
  }

  webauthn = {
    enroll = (contains(var.required_authenticators, "WEBAUTHN")
      ? "REQUIRED"
      : (contains(var.optional_authenticators, "WEBAUTHN")
        ? "OPTIONAL"
        : null
      )
    )
  }
}

resource "okta_policy_mfa_default" "this" {
  count = local.is_default ? 1 : 0

  is_oie = true


  ## Authenticators
  google_otp = {
    enroll = (contains(var.required_authenticators, "GOOGLE_OTP")
      ? "REQUIRED"
      : (contains(var.optional_authenticators, "GOOGLE_OTP")
        ? "OPTIONAL"
        : null
      )
    )
  }

  okta_email = {
    enroll = (contains(var.required_authenticators, "OKTA_EMAIL")
      ? "REQUIRED"
      : (contains(var.optional_authenticators, "OKTA_EMAIL")
        ? "OPTIONAL"
        : null
      )
    )
  }

  okta_password = {
    enroll = (contains(var.required_authenticators, "OKTA_PASSWORD")
      ? "REQUIRED"
      : (contains(var.optional_authenticators, "OKTA_PASSWORD")
        ? "OPTIONAL"
        : null
      )
    )
  }

  okta_verify = {
    enroll = (contains(var.required_authenticators, "OKTA_VERIFY")
      ? "REQUIRED"
      : (contains(var.optional_authenticators, "OKTA_VERIFY")
        ? "OPTIONAL"
        : null
      )
    )
  }

  phone_number = {
    enroll = (contains(var.required_authenticators, "PHONE_NUMBER")
      ? "REQUIRED"
      : (contains(var.optional_authenticators, "PHONE_NUMBER")
        ? "OPTIONAL"
        : null
      )
    )
  }

  security_question = {
    enroll = (contains(var.required_authenticators, "SECURITY_QUESTION")
      ? "REQUIRED"
      : (contains(var.optional_authenticators, "SECURITY_QUESTION")
        ? "OPTIONAL"
        : null
      )
    )
  }

  webauthn = {
    enroll = (contains(var.required_authenticators, "WEBAUTHN")
      ? "REQUIRED"
      : (contains(var.optional_authenticators, "WEBAUTHN")
        ? "OPTIONAL"
        : null
      )
    )
  }
}


###################################################
# Okta Groups for Password Policy
###################################################

data "okta_group" "this" {
  for_each = toset(var.groups)

  id = each.value
}
