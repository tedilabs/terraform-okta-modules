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
# Okta Application (Bookmark)
###################################################

# INFO: TODO
# - `app_links_json`
# INFO: Not supported attributes
# - `accessibility_login_redirect_url`
# - `accessibility_self_service`
# - `auto_submit_toolbar`
resource "okta_app_bookmark" "this" {
  label  = var.name
  url    = var.url
  logo   = var.logo_path
  status = var.enabled ? "ACTIVE" : "INACTIVE"


  ## Sign-on
  authentication_policy = var.sign_on.authentication_policy


  ## Notes
  admin_note   = var.notes.admin
  enduser_note = var.notes.user


  ## Accessibility
  # accessibility_self_service = var.self_service_enabled
  accessibility_error_redirect_url = var.custom_error_page

  hide_ios = var.hide_app_on_ios
  hide_web = var.hide_app_on_web


  ## Misc
  request_integration = false
}


###################################################
# User Assignments for Okta Application
###################################################

resource "okta_app_user" "this" {
  for_each = {
    for assignment in var.user_assignments :
    assignment.user => assignment
  }

  app_id = okta_app_bookmark.this.id

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
  app_id = okta_app_bookmark.this.id

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
