output "name" {
  description = "The name of the MFA provider."
  value       = upper(okta_factor.this.provider_id)
}

output "enabled" {
  description = "Whether this factor is activated."
  value       = okta_factor.this.active
}

# output "debug" {
#   value = {
#     for k, v in okta_factor.this :
#     k => v
#     if !contains(["provider_id", "active", "id"], k)
#   }
# }
