output "id" {
  description = "The ID of the bookmark application."
  value       = okta_app_bookmark.this.id
}

output "catalog_id" {
  description = "The ID of the application template in Okta application catalog."
  value       = okta_app_bookmark.this.name
}

output "name" {
  description = "The label of the bookmark application."
  value       = okta_app_bookmark.this.label
}

output "url" {
  description = "The URL of the bookmark application."
  value       = okta_app_bookmark.this.url
}

output "logo_url" {
  description = "The URL of the application logo."
  value       = okta_app_bookmark.this.logo_url
}

output "enabled" {
  description = "Whether to enable the bookmark application."
  value       = okta_app_bookmark.this.status == "ACTIVE"
}

output "sign_on" {
  description = "The configurations for application sign-on."
  value = {
    method                = okta_app_bookmark.this.sign_on_mode
    authentication_policy = okta_app_bookmark.this.authentication_policy
  }
}

# output "self_service_enabled" {
#   description = "Whether to enable self-service."
#   value       = okta_app_bookmark.this.accessibility_self_service
# }

output "notes" {
  description = "The configurations for application notes."
  value = {
    "admin" = okta_app_bookmark.this.admin_note
    "user"  = okta_app_bookmark.this.enduser_note
  }
}

output "custom_error_page" {
  description = "The URL for custom error page."
  value       = okta_app_bookmark.this.accessibility_error_redirect_url
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
#     for k, v in okta_app_bookmark.this :
#     k => v
#     if !contains(["id", "label", "url", "status", "authentication_policy", "accessibility_error_redirect_url", "timeouts", "request_integration", "accessibility_login_redirect_url", "accessibility_self_service", "hide_ios", "hide_web", "enduser_note", "admin_note", "auto_submit_toolbar", "logo", "logo_url", "name", "sign_on_mode"], k)
#   }
# }
