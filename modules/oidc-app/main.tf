data "okta_user" "this" {
  for_each = toset([
    for assignment in var.user_assignments :
    assignment.user
  ])

  user_id = each.value
}

data "okta_group" "this" {
  for_each = toset([
    for assignment in var.group_assignments :
    assignment.group
  ])

  id = each.value
}

locals {
  user_assignments = {
    for assignment in var.user_assignments :
    assignment.user => {
      user = {
        id   = data.okta_user.this[assignment.user].id
        name = data.okta_user.this[assignment.user].login
      }
      profile  = okta_app_user.this[assignment.user].profile
      username = okta_app_user.this[assignment.user].username
    }
  }
  group_assignments = {
    for assignment in var.group_assignments :
    assignment.group => merge(assignment, {
      group = {
        id   = data.okta_group.this[assignment.group].id
        name = data.okta_group.this[assignment.group].name
      }
    })
  }
}

###################################################
# Okta Application (OIDC)
###################################################

# INFO: TODO
# accessibility_error_redirect_url (String) Custom error page URL
# accessibility_login_redirect_url (String) Custom login page URL
# accessibility_self_service (Boolean) Enable self service. Default is false
# app_links_json (String) Displays specific appLinks for the app. The value for each application link should be boolean.
# app_settings_json (String) Application settings in JSON format
# auto_key_rotation (Boolean) Requested key rotation mode. If auto_key_rotation isn't specified, the client automatically opts in for Okta's key rotation. You can update this property via the API or via the administrator UI. See: https://developer.okta.com/docs/reference/api/apps/#oauth-credential-object"
# auto_submit_toolbar (Boolean) Display auto submit toolbar
# client_basic_secret (String, Sensitive) The user provided OAuth client secret key value, this can be set when token_endpoint_auth_method is client_secret_basic. This does nothing when `omit_secret is set to true.
# client_uri (String) URI to a web page providing information about the client.
# jwks (Block List) (see below for nested schema)
# jwks_uri (String) URL reference to JWKS
# login_mode (String) The type of Idp-Initiated login that the client supports, if any
# login_scopes (Set of String) List of scopes to use for the request
# profile (String) Custom JSON that represents an OAuth application's profile
# refresh_token_leeway (Number) Early Access Property Grace period for token rotation, required with grant types refresh_token
# refresh_token_rotation (String) Early Access Property Refresh token rotation behavior, required with grant types refresh_token
# timeouts (Block, Optional) (see below for nested schema)
# INFO: Not supported attributes
# - `accessibility_login_redirect_url`
# - `accessibility_self_service`
# - `auto_submit_toolbar`
resource "okta_app_oauth" "this" {
  label  = var.name
  type   = var.type
  logo   = var.logo_path
  status = var.enabled ? "ACTIVE" : "INACTIVE"

  grant_types    = var.grant_types
  response_types = var.response_types


  ## Client Authentication
  token_endpoint_auth_method = var.client_authentication.method
  client_id                  = var.client_authentication.client_id
  pkce_required              = var.client_authentication.pkce_required
  omit_secret                = true


  ## Login
  redirect_uris             = var.login.redirect_uris
  post_logout_redirect_uris = var.login.post_logout_redirect_uris
  login_uri                 = var.login.initiate_login_uri
  wildcard_redirect         = var.login.allow_wildcard_redirect ? "ENABLED" : "DISABLED"


  ## OIDC ID Token
  issuer_mode = var.oidc_id_token.issuer_mode

  dynamic "groups_claim" {
    for_each = var.oidc_id_token.groups_claim_filter != null ? [var.oidc_id_token.groups_claim_filter] : []
    iterator = filter

    content {
      type = "FILTER"

      filter_type = filter.value.type
      name        = filter.value.name
      value       = filter.value.value
    }
  }


  ## Federation Broker Mode
  implicit_assignment = var.federation_broker_mode.enabled


  ## User Consent
  consent_method = var.user_consent.method
  logo_uri       = var.user_consent.logo_uri
  policy_uri     = var.user_consent.policy_uri
  tos_uri        = var.user_consent.tos_uri


  ## Sign-on
  authentication_policy = var.sign_on.authentication_policy

  user_name_template_type = var.sign_on.user_name_template.type
  user_name_template      = var.sign_on.user_name_template.template
  user_name_template_suffix = (var.sign_on.user_name_template.type == "BUILT_IN"
    ? var.sign_on.user_name_template.suffix
    : null
  )
  user_name_template_push_status = (var.sign_on.user_name_template.type == "CUSTOM"
    ? var.sign_on.user_name_template.push_status
    : null
  )


  ## Notes
  admin_note   = var.notes.admin
  enduser_note = var.notes.user


  ## Accessibility
  # accessibility_self_service       = var.self_service.enabled
  # accessibility_error_redirect_url = var.custom_error_page

  hide_ios = var.hide_app_on_ios
  hide_web = var.hide_app_on_web

  lifecycle {
    ignore_changes = [
      app_settings_json,
    ]
  }
}


###################################################
# User Assignments for Okta Application
###################################################

resource "okta_app_user" "this" {
  for_each = {
    for assignment in var.user_assignments :
    assignment.user => assignment
  }

  app_id = okta_app_oauth.this.id

  user_id = each.key
  profile = jsonencode(each.value.profile)

  username = each.value.username
  password = each.value.password

  retain_assignment = false
}


###################################################
# Group Assignments for Okta Application
###################################################

# INFO: There is alternative resource `okta_app_group_assignment`
resource "okta_app_group_assignments" "this" {
  app_id = okta_app_oauth.this.id

  dynamic "group" {
    for_each = {
      for assignment in var.group_assignments :
      assignment.group => assignment
    }

    content {
      id       = group.key
      priority = group.value.priority
      profile  = jsonencode(group.value.profile)
    }
  }
}
