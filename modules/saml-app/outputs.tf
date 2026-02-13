output "id" {
  description = "The ID of the SAML application."
  value       = okta_app_saml.this.id
}

output "catalog_id" {
  description = "The ID of the application template in Okta application catalog."
  value       = okta_app_saml.this.name
}

output "preconfigured_app" {
  description = "The name of a preconfigured app from the Okta App Integration Network."
  value       = okta_app_saml.this.preconfigured_app
}

output "name" {
  description = "The label of the SAML application."
  value       = okta_app_saml.this.label
}

output "logo_url" {
  description = "The URL of the application logo."
  value       = okta_app_saml.this.logo_url
}

output "embed_url" {
  description = "The embed URL of the SAML application."
  value       = okta_app_saml.this.embed_url
}

output "enabled" {
  description = "Whether to enable the SAML application."
  value       = okta_app_saml.this.status == "ACTIVE"
}

output "app_settings" {
  description = "The application settings."
  value = (one(okta_app_saml_app_settings.this[*].settings) != null
    ? jsondecode(okta_app_saml_app_settings.this[0].settings)
    : okta_app_saml.this.app_settings_json
  )
}

output "saml_version" {
  description = "The SAML version used by the application."
  value       = okta_app_saml.this.saml_version
}

output "saml_metadata" {
  description = "The SAML metadata configurations."
  value = {
    url                   = okta_app_saml.this.metadata_url
    signing_certificate   = okta_app_saml.this.certificate
    issuer                = okta_app_saml.this.entity_key
    http_post_binding     = okta_app_saml.this.http_post_binding
    http_redirect_binding = okta_app_saml.this.http_redirect_binding
  }
}

output "saml_config" {
  description = "The SAML configurations for the application."
  value = {
    sso_url         = okta_app_saml.this.sso_url
    recipient_url   = okta_app_saml.this.recipient
    destination_url = okta_app_saml.this.destination
    audience        = okta_app_saml.this.audience

    subject_name_id = {
      format   = okta_app_saml.this.subject_name_id_format
      template = okta_app_saml.this.subject_name_id_template
    }

    assertion_signed    = okta_app_saml.this.assertion_signed
    response_signed     = okta_app_saml.this.response_signed
    digest_algorithm    = okta_app_saml.this.digest_algorithm
    signature_algorithm = okta_app_saml.this.signature_algorithm

    authn_context_class_ref = okta_app_saml.this.authn_context_class_ref
    honor_force_authn       = okta_app_saml.this.honor_force_authn
  }
}

output "saml_attributes" {
  description = "A list of SAML attribute statements for the application."
  value = [
    for attribute in okta_app_saml.this.attribute_statements :
    {
      type      = attribute.type
      namespace = attribute.namespace
      name      = attribute.name
      values    = attribute.values
      filter = (attribute.type == "GROUP"
        ? {
          type  = attribute.filter_type
          value = attribute.filter_value
        }
        : null
      )
    }
  ]
}

output "single_logout" {
  description = "The configurations for single logout."
  value = {
    issuer      = okta_app_saml.this.single_logout_issuer
    url         = okta_app_saml.this.single_logout_url
    certificate = okta_app_saml.this.single_logout_certificate
  }
}

output "sign_on" {
  description = "The configurations for application sign-on."
  value = {
    method                = okta_app_saml.this.sign_on_mode
    authentication_policy = okta_app_saml.this.authentication_policy
    user_name_template = {
      type        = okta_app_saml.this.user_name_template_type
      template    = okta_app_saml.this.user_name_template
      suffix      = okta_app_saml.this.user_name_template_suffix
      push_status = okta_app_saml.this.user_name_template_push_status
    }
  }
}

output "features" {
  description = "The features enabled for the SAML application."
  value       = okta_app_saml.this.features
}

# output "self_service_enabled" {
#   description = "Whether to enable self-service."
#   value       = okta_app_saml.this.accessibility_self_service
# }

output "notes" {
  description = "The configurations for application notes."
  value = {
    "admin" = okta_app_saml.this.admin_note
    "user"  = okta_app_saml.this.enduser_note
  }
}

output "app_links" {
  description = "The application links for the SAML application."
  value = (okta_app_saml.this.app_links_json != null
    ? jsondecode(okta_app_saml.this.app_links_json)
    : null
  )
}

output "custom_error_page" {
  description = "The URL for custom error page."
  value       = okta_app_saml.this.accessibility_error_redirect_url
}

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
#     for k, v in okta_app_saml.this :
#     k => v
#     if !contains(["id", "label", "url", "status", "authentication_policy", "accessibility_error_redirect_url", "timeouts", "request_integration", "accessibility_login_redirect_url", "accessibility_self_service", "hide_ios", "hide_web", "enduser_note", "admin_note", "auto_submit_toolbar", "logo", "logo_url", "name", "sign_on_mode", "features", "single_logout_issuer", "single_logout_url", "single_logout_certificate", "user_name_template_type", "user_name_template_suffix", "user_name_template_push_status", "user_name_template", "app_links_json", "metadata_url", "certificate", "preconfigured_app", "entity_key", "embed_url", "app_settings_json", "saml_version", "metadata", "http_post_binding", "http_redirect_binding", "digest_algorithm", "signature_algorithm", "sso_url", "recipient", "destination", "audience", "subject_name_id_format", "subject_name_id_template", "assertion_signed", "response_signed", "authn_context_class_ref", "honor_force_authn"], k)
#   }
# }
