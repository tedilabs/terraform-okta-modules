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
  is_preconfigured = var.preconfigured_app != null

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
# Okta Application (SAML)
###################################################

# INFO: TODO
# - ``
# INFO: Not supported attributes
# - `accessibility_login_redirect_url`
# - `accessibility_self_service`
# - `auto_submit_toolbar`
resource "okta_app_saml" "this" {
  label             = var.name
  preconfigured_app = var.preconfigured_app
  logo              = var.logo_path
  status            = var.enabled ? "ACTIVE" : "INACTIVE"


  ## SAML Config
  sso_url = (!local.is_preconfigured
    ? var.saml_config.sso_url
    : null
  )
  recipient = (!local.is_preconfigured
    ? var.saml_config.recipient_url
    : null
  )
  destination = (!local.is_preconfigured
    ? var.saml_config.destination_url
    : null
  )
  audience = (!local.is_preconfigured
    ? var.saml_config.audience
    : null
  )

  subject_name_id_format = (!local.is_preconfigured
    ? var.saml_config.subject_name_id.format
    : null
  )
  subject_name_id_template = (!local.is_preconfigured
    ? var.saml_config.subject_name_id.template
    : null
  )

  assertion_signed = (!local.is_preconfigured
    ? var.saml_config.assertion_signed
    : null
  )
  response_signed = (!local.is_preconfigured
    ? var.saml_config.response_signed
    : null
  )
  digest_algorithm = (!local.is_preconfigured
    ? var.saml_config.digest_algorithm
    : null
  )
  signature_algorithm = (!local.is_preconfigured
    ? var.saml_config.signature_algorithm
    : null
  )

  authn_context_class_ref = (!local.is_preconfigured
    ? var.saml_config.authn_context_class_ref
    : null
  )
  honor_force_authn = (!local.is_preconfigured
    ? var.saml_config.honor_force_authn
    : null
  )


  ## SAML Attribute Statements
  dynamic "attribute_statements" {
    for_each = var.saml_attributes
    iterator = attribute

    content {
      type      = attribute.value.type
      namespace = attribute.value.namespace
      name      = attribute.value.name
      values    = attribute.value.values

      filter_type = (attribute.value.type == "GROUP" && attribute.value.filter != null
        ? attribute.value.filter.type
        : null
      )
      filter_value = (attribute.value.type == "GROUP" && attribute.value.filter != null
        ? attribute.value.filter.value
        : null
      )
    }
  }


  ## Single Logout
  single_logout_issuer      = var.single_logout.issuer
  single_logout_url         = var.single_logout.url
  single_logout_certificate = var.single_logout.certificate


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
  accessibility_self_service       = var.self_service.enabled
  accessibility_error_redirect_url = var.custom_error_page

  hide_ios = var.hide_app_on_ios
  hide_web = var.hide_app_on_web

  lifecycle {
    ignore_changes = [
      app_settings_json,
    ]
  }
}


###################################################
# Settings for Okta SAML Application
###################################################

resource "okta_app_saml_app_settings" "this" {
  count = var.app_settings != null ? 1 : 0

  app_id = okta_app_saml.this.id

  settings = jsonencode(var.app_settings)
}


###################################################
# User Assignments for Okta Application
###################################################

resource "okta_app_user" "this" {
  for_each = {
    for assignment in var.user_assignments :
    assignment.user => assignment
  }

  app_id = okta_app_saml.this.id

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
  app_id = okta_app_saml.this.id

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
