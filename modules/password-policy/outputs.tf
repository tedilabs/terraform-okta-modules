output "id" {
  description = "The ID of the Okta Password Policy."
  value       = local.policy.id
}

output "name" {
  description = "The name of the Okta Password Policy."
  value       = local.policy.name
}

output "description" {
  description = "The description of the Okta Password Policy."
  value       = local.policy.description
}

output "enabled" {
  description = "Whether the Okta Password Policy is enabled."
  value       = local.policy.status == "ACTIVE"
}

output "authentication_provider" {
  description = "The authentication provider which the Okta Password Policy applies to."
  value       = local.policy.auth_provider
}

output "priority" {
  description = "The priority of the Okta Password Policy."
  value       = local.policy.priority
}

output "groups" {
  description = "The information for the assigned groups of the Okta Password Policy."
  value = [
    for group in data.okta_group.this :
    group.name
  ]
}

output "complexity" {
  description = "The complexity requirements of the Okta Password Policy."
  value = {
    min_length = local.policy.password_min_length

    lowercase_required = local.policy.password_min_lowercase == 1
    uppercase_required = local.policy.password_min_uppercase == 1
    number_required    = local.policy.password_min_number == 1
    symbol_required    = local.policy.password_min_symbol == 1

    first_name_restricted      = local.policy.password_exclude_first_name
    last_name_restricted       = local.policy.password_exclude_last_name
    username_restricted        = local.policy.password_exclude_username
    common_password_restricted = local.policy.password_dictionary_lookup

    reuse_restriction_count = local.policy.password_history_count
  }
}

output "expiration" {
  description = "The configuration for password expiration of the Okta Password Policy."
  value = {
    max_age_days       = local.policy.password_max_age_days
    min_age_minutes    = local.policy.password_min_age_minutes
    remind_before_days = local.policy.password_expire_warn_days
  }
}

output "lockout" {
  description = "The configuration for password lock-out of the Okta Password Policy."
  value = {
    max_attempts          = local.policy.password_max_lockout_attempts
    duration              = local.policy.password_auto_unlock_minutes
    show_failures         = local.policy.password_show_lockout_failures
    notification_channels = local.policy.password_lockout_notification_channels
  }
}

output "recovery" {
  description = "The configuration for password recovery of the Okta Password Policy."
  value = {
    call = {
      enabled = local.policy.call_recovery == "ACTIVE"
    }
    email = {
      enabled   = local.policy.email_recovery == "ACTIVE"
      token_ttl = local.policy.recovery_email_token
    }
    question = {
      enabled           = local.policy.question_recovery == "ACTIVE"
      min_answer_length = local.policy.question_min_length
    }
    sms = {
      enabled = local.policy.sms_recovery == "ACTIVE"
    }
  }
}

output "rules" {
  description = "The configuration for rules of the Okta Password Policy."
  value = {
    for name, rule in okta_policy_rule_password.this :
    name => {
      id       = rule.id
      name     = rule.name
      priority = rule.priority
      enabled  = rule.status == "ACTIVE"

      condition = {
        excluded_users = rule.users_excluded
        network = {
          connection = rule.network_connection

          excluded_zones = rule.network_excludes
          included_zones = rule.network_includes
        }
      }

      allow_password_change = rule.password_change == "ALLOW"
      allow_password_reset  = rule.password_reset == "ALLOW"
      allow_password_unlock = rule.password_unlock == "ALLOW"
    }
  }
}

# output "debug" {
#   value = {
#     for k, v in okta_app_signon_policy.this :
#     k => v
#     if !contains(["id", "name", "description"], k)
#   }
# }
