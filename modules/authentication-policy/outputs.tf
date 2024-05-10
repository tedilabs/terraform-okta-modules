output "id" {
  description = "The ID of the Okta Authentication Policy."
  value       = okta_app_signon_policy.this.id
}

output "name" {
  description = "The name of the Okta Authentication Policy."
  value       = okta_app_signon_policy.this.name
}

output "description" {
  description = "The description of the Okta Authentication Policy."
  value       = okta_app_signon_policy.this.description
}

# output "debug" {
#   value = {
#     for k, v in okta_app_signon_policy.this :
#     k => v
#     if !contains(["id", "name", "description"], k)
#   }
# }
