output "id" {
  description = "The ID of the authorization server."
  value       = okta_auth_server.this.id
}

output "kid" {
  description = "The ID of the JSON Web Key used for signing tokens issued by the authorization server."
  value       = okta_auth_server.this.kid
}

output "name" {
  description = "The display name of the authorization server."
  value       = okta_auth_server.this.name
}

output "description" {
  description = "The description of the authorization server."
  value       = okta_auth_server.this.description
}

output "enabled" {
  description = "Whether this authorization server is activated."
  value       = okta_auth_server.this.status == "ACTIVE"
}

output "audiences" {
  description = "The audiences of the authorization server."
  value       = okta_auth_server.this.audiences
}

output "issuer" {
  description = "The issuer configuration of the authorization server."
  value = {
    mode         = okta_auth_server.this.issuer_mode
    metadata_uri = okta_auth_server.this.issuer
  }
}

output "signing_key" {
  description = "The signing key configuration of the authorization server."
  value = {
    rotation_mode   = okta_auth_server.this.credentials_rotation_mode
    last_rotated_at = okta_auth_server.this.credentials_last_rotated
    next_rotate_at  = okta_auth_server.this.credentials_next_rotation
  }
}

output "claims" {
  description = "The claims of the authorization server."
  value = [
    for claim in okta_auth_server_claim.this :
    {
      id = claim.id
      token_type = {
        for k, v in local.claim_types :
        v => k
      }[claim.claim_type]
      always_include_in_token = claim.always_include_in_token

      name       = claim.name
      value_type = claim.value_type
      operator   = claim.group_filter_type
      value      = claim.value

      enabled = claim.status == "ACTIVE"
      scopes  = claim.scopes
    }
  ]
}

# output "debug" {
#   value = {
#     for k, v in okta_auth_server.this :
#     k => v
#     if !contains(["name", "status", "id", "description", "issuer_mode", "audiences", "credentials_rotation_mode", "kid", "credentials_last_rotated", "credentials_next_rotation", "issuer"], k)
#   }
# }
