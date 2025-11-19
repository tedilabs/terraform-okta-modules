output "id" {
  description = "The ID of the OIDC application."
  value       = okta_app_oauth.this.id
}

output "name" {
  description = "The label of the OIDC application."
  value       = okta_app_oauth.this.label
}

output "type" {
  description = "The type of the OIDC application."
  value       = okta_app_oauth.this.type
}

output "logo_url" {
  description = "The URL of the application logo."
  value       = okta_app_oauth.this.logo_url
}

output "enabled" {
  description = "Whether to enable the OIDC application."
  value       = okta_app_oauth.this.status == "ACTIVE"
}

# output "app_settings" {
#   description = "The application settings."
#   value = jsondecode(one(okta_app_oauth_app_settings.this[*].settings) != null
#     ? okta_app_oauth_app_settings.this[0].settings
#     : okta_app_oauth.this.app_settings_json
#   )
# }

output "grant_types" {
  description = "The OAuth 2.0 grant types supported by the OIDC application."
  value       = okta_app_oauth.this.grant_types
}

output "response_types" {
  description = "The OAuth 2.0 response types supported by the OIDC application."
  value       = okta_app_oauth.this.response_types
}

output "client_authentication" {
  description = "The client authentication method for the OIDC application."
  value = {
    method        = okta_app_oauth.this.token_endpoint_auth_method
    client_id     = okta_app_oauth.this.client_id
    pkce_required = okta_app_oauth.this.pkce_required
  }
}

output "login" {
  description = "The configurations for application login."
  value = {
    redirect_uris             = okta_app_oauth.this.redirect_uris
    post_logout_redirect_uris = okta_app_oauth.this.post_logout_redirect_uris
    initiate_login_uri        = okta_app_oauth.this.login_uri
    allow_wildcard_redirect   = okta_app_oauth.this.wildcard_redirect == "ENABLED"
  }
}

output "oidc_id_token" {
  description = "The configurations for OIDC ID token."
  value = {
    issuer_mode = okta_app_oauth.this.issuer_mode
    groups_claim_filter = (
      length(okta_app_oauth.this.groups_claim) > 0
      ? {
        type  = one(okta_app_oauth.this.groups_claim[*].type)
        name  = one(okta_app_oauth.this.groups_claim[*].name)
        value = one(okta_app_oauth.this.groups_claim[*].value)
      }
      : null
    )
  }
}

output "federation_broker_mode" {
  description = "The configuration for federation broker mode."
  value = {
    enabled = okta_app_oauth.this.implicit_assignment
  }
}

output "user_consent" {
  description = "The configurations for user consent of the OIDC application."
  value = {
    method     = okta_app_oauth.this.consent_method
    logo_uri   = okta_app_oauth.this.logo_uri
    policy_uri = okta_app_oauth.this.policy_uri
    tos_uri    = okta_app_oauth.this.tos_uri
  }
}

output "sign_on" {
  description = "The configurations for application sign-on."
  value = {
    method                = okta_app_oauth.this.sign_on_mode
    authentication_policy = okta_app_oauth.this.authentication_policy
    user_name_template = {
      type        = okta_app_oauth.this.user_name_template_type
      template    = okta_app_oauth.this.user_name_template
      suffix      = okta_app_oauth.this.user_name_template_suffix
      push_status = okta_app_oauth.this.user_name_template_push_status
    }
  }
}

# output "self_service_enabled" {
#   description = "Whether to enable self-service."
#   value       = okta_app_oauth.this.accessibility_self_service
# }

output "notes" {
  description = "The configurations for application notes."
  value = {
    "admin" = okta_app_oauth.this.admin_note
    "user"  = okta_app_oauth.this.enduser_note
  }
}

# output "app_links" {
#   description = "The application links for the OIDC application."
#   value       = jsondecode(okta_app_oauth.this.app_links_json)
# }

# output "custom_error_page" {
#   description = "The URL for custom error page."
#   value       = okta_app_oauth.this.accessibility_error_redirect_url
# }

output "user_assignments" {
  description = "The information for the assigned users to the application."
  value       = values(local.user_assignments)
}

output "group_assignments" {
  description = "The information for the assigned groups to the application."
  value       = values(local.group_assignments)
}

# output "debug" {
#   value = {
#     for k, v in okta_app_oauth.this :
#     k => v
#     if !contains(["id", "label", "status", "authentication_policy", "timeouts", "enduser_note", "admin_note", "sign_on_mode", "logo_uri", "policy_uri", "tos_uri", "grant_types", "response_types", "redirect_uris", "post_logout_redirect_uris", "login_uri", "token_endpoint_auth_method", "implicit_assignment", "wildcard_redirect", "issuer_mode", "groups_claim", "consent_method", "client_id", "pkce_required", "omit_secret", "type", "hide_ios", "hide_web", "logo", "logo_url", "user_name_template_suffix", "user_name_template_type", "user_name_template_push_status", "user_name_template"], k) && !contains(["client_secret", "client_basic_secret"], k)
#   }
# }
