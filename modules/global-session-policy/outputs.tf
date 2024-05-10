output "id" {
  description = "The ID of the Okta Global Session Policy."
  value       = okta_policy_signon.this.id
}

output "name" {
  description = "The name of the Okta Global Session Policy."
  value       = okta_policy_signon.this.name
}

output "description" {
  description = "The description of the Okta Global Session Policy."
  value       = okta_policy_signon.this.description
}

output "enabled" {
  description = "Whether to enable the Okta Global Session Policy."
  value       = okta_policy_signon.this.status == "ACTIVE"
}

output "priority" {
  description = "The priority of the Okta Global Session Policy."
  value       = okta_policy_signon.this.priority
}

output "groups" {
  description = "The information for the assigned groups of the Okta Global Session Policy."
  value = [
    for group in data.okta_group.this :
    group.name
  ]
}

# output "debug" {
#   value = {
#     for k, v in okta_policy_signon.this :
#     k => v
#     if !contains(["id", "name", "description", "status", "priority", "groups_included"], k)
#   }
# }
