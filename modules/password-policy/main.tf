locals {
  is_default = var.name == "default"

  policy = (local.is_default
    ? merge(okta_policy_password_default.this[0], {
      auth_provider = okta_policy_password_default.this[0].default_auth_provider
    })
    : okta_policy_password.this[0]
  )
}


###################################################
# Okta Password Policy
###################################################

# TODO:
# `skip_unlock` (Boolean) When an Active Directory user is locked out of Okta, the Okta unlock operation should also attempt to unlock the user's Windows account. Default: false
resource "okta_policy_password" "this" {
  count = local.is_default ? 0 : 1

  name        = var.name
  description = var.description
  status      = var.enabled ? "ACTIVE" : "INACTIVE"

  auth_provider   = var.authentication_provider
  priority        = var.priority
  groups_included = var.groups


  ## Complexity Requirements
  password_min_length = var.complexity.min_length

  password_min_lowercase = var.complexity.lowercase_required ? 1 : 0
  password_min_uppercase = var.complexity.uppercase_required ? 1 : 0
  password_min_number    = var.complexity.number_required ? 1 : 0
  password_min_symbol    = var.complexity.symbol_required ? 1 : 0

  password_exclude_first_name = var.complexity.first_name_restricted
  password_exclude_last_name  = var.complexity.last_name_restricted
  password_exclude_username   = var.complexity.username_restricted
  password_dictionary_lookup  = var.complexity.common_password_restricted

  password_history_count = var.complexity.reuse_restriction_count


  ## Expiration
  password_max_age_days     = var.expiration.max_age_days
  password_min_age_minutes  = var.expiration.min_age_minutes
  password_expire_warn_days = var.expiration.remind_before_days


  ## Lock-out
  password_max_lockout_attempts          = var.lockout.max_attempts
  password_auto_unlock_minutes           = var.lockout.duration
  password_show_lockout_failures         = var.lockout.show_failures
  password_lockout_notification_channels = var.lockout.notification_channels


  ## Recovery
  call_recovery = var.recovery.call.enabled ? "ACTIVE" : "INACTIVE"

  email_recovery       = var.recovery.email.enabled ? "ACTIVE" : "INACTIVE"
  recovery_email_token = var.recovery.email.token_ttl

  question_recovery   = var.recovery.question.enabled ? "ACTIVE" : "INACTIVE"
  question_min_length = var.recovery.question.min_answer_length

  sms_recovery = var.recovery.sms.enabled ? "ACTIVE" : "INACTIVE"
}

resource "okta_policy_password_default" "this" {
  count = local.is_default ? 1 : 0


  ## Complexity Requirements
  password_min_length = var.complexity.min_length

  password_min_lowercase = var.complexity.lowercase_required ? 1 : 0
  password_min_uppercase = var.complexity.uppercase_required ? 1 : 0
  password_min_number    = var.complexity.number_required ? 1 : 0
  password_min_symbol    = var.complexity.symbol_required ? 1 : 0

  password_exclude_first_name = var.complexity.first_name_restricted
  password_exclude_last_name  = var.complexity.last_name_restricted
  password_exclude_username   = var.complexity.username_restricted
  password_dictionary_lookup  = var.complexity.common_password_restricted

  password_history_count = var.complexity.reuse_restriction_count


  ## Expiration
  password_max_age_days     = var.expiration.max_age_days
  password_min_age_minutes  = var.expiration.min_age_minutes
  password_expire_warn_days = var.expiration.remind_before_days


  ## Lock-out
  password_max_lockout_attempts          = var.lockout.max_attempts
  password_auto_unlock_minutes           = var.lockout.duration
  password_show_lockout_failures         = var.lockout.show_failures
  password_lockout_notification_channels = var.lockout.notification_channels


  ## Recovery
  call_recovery = var.recovery.call.enabled ? "ACTIVE" : "INACTIVE"

  email_recovery       = var.recovery.email.enabled ? "ACTIVE" : "INACTIVE"
  recovery_email_token = var.recovery.email.token_ttl

  question_recovery   = var.recovery.question.enabled ? "ACTIVE" : "INACTIVE"
  question_min_length = var.recovery.question.min_answer_length

  sms_recovery = var.recovery.sms.enabled ? "ACTIVE" : "INACTIVE"
}


###################################################
# Okta Groups for Password Policy
###################################################

data "okta_group" "this" {
  for_each = toset(var.groups)

  id = each.value
}
