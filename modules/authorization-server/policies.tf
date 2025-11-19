
###################################################
# Access Policies for Authorization Server
###################################################

resource "okta_auth_server_policy" "this" {
  for_each = {
    for policy in var.access_policies :
    policy.name => policy
  }

  auth_server_id = okta_auth_server.this.id

  priority = each.value.priority

  name        = each.key
  description = each.value.description
  status      = each.value.enabled ? "ACTIVE" : "INACTIVE"

  client_whitelist = each.value.assigned_clients
}
