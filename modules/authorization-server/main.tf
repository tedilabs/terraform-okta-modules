locals {
  claim_types = {
    "ACCESS_TOKEN" = "RESOURCE"
    "ID_TOKEN"     = "IDENTITY"
  }
}


###################################################
# Authorization Server
###################################################

resource "okta_auth_server" "this" {
  name        = var.name
  description = var.description
  status      = var.enabled ? "ACTIVE" : "INACTIVE"

  audiences                 = var.audiences
  issuer_mode               = var.issuer.mode
  credentials_rotation_mode = var.signing_key.rotation_mode
}


###################################################
# Claims of Authorization Server
###################################################

resource "okta_auth_server_claim" "this" {
  for_each = {
    for claim in var.claims :
    claim.name => claim
  }

  auth_server_id = okta_auth_server.this.id

  claim_type              = local.claim_types[each.value.token_type]
  always_include_in_token = each.value.always_include_in_token

  name = each.value.name
  group_filter_type = (each.value.value_type == "GROUPS"
    ? each.value.operator
    : null
  )
  value_type = each.value.value_type
  value      = each.value.value

  status = each.value.enabled ? "ACTIVE" : "INACTIVE"
  scopes = each.value.scopes
}
