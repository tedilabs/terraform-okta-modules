output "id" {
  description = "The ID of the authenticator."
  value       = okta_authenticator.this.id
}

output "name" {
  description = "The display name of the authenticator."
  value       = okta_authenticator.this.name
}

output "category" {
  description = "The category of the authenticator provider."
  value       = okta_authenticator.this.type
}

output "type" {
  description = "The type of the authenticator provider."
  value       = upper(okta_authenticator.this.key)
}

output "enabled" {
  description = "Whether this authenticator is activated."
  value       = okta_authenticator.this.status == "ACTIVE"
}

output "settings" {
  description = "The settings of the authenticator"
  value       = okta_authenticator.this.settings != null ? jsondecode(okta_authenticator.this.settings) : null
}

# output "debug" {
#   value = {
#     for k, v in okta_authenticator.this :
#     k => v
#     if !contains(["name", "status", "id", "key", "type", "legacy_ignore_name"], k)
#   }
# }
