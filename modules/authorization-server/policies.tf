
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


###################################################
# Rules of Access Policies for Authorization Server
###################################################

locals {
  access_policy_rules = {
    for rule in flatten([
      for policy in var.access_policies : [
        for idx, rule in policy.rules :
        merge(rule, {
          policy   = policy.name
          priority = coalesce(rule.priority, idx + 1)
        })
      ]
    ]) :
    "${rule.policy}/${rule.name}" => rule
  }
}

# INFO: Not supported attributes
# - `type`
# WARNING: The Okta API assigns rule priorities within a policy sequentially. Terraform
# creates the rules of a policy concurrently, so a rule may briefly land on a priority
# other than the requested one until the next apply reconciles it.
resource "okta_auth_server_policy_rule" "this" {
  for_each = local.access_policy_rules

  auth_server_id = okta_auth_server.this.id
  policy_id      = okta_auth_server_policy.this[each.value.policy].id

  name     = each.value.name
  priority = each.value.priority
  status   = each.value.enabled ? "ACTIVE" : "INACTIVE"


  ## Conditions
  grant_type_whitelist = each.value.condition.grant_types
  scope_whitelist      = each.value.condition.scopes

  user_whitelist  = each.value.condition.included_users
  user_blacklist  = each.value.condition.excluded_users
  group_whitelist = each.value.condition.included_groups
  group_blacklist = each.value.condition.excluded_groups


  ## Tokens
  access_token_lifetime_minutes  = each.value.access_token.lifetime
  refresh_token_lifetime_minutes = each.value.refresh_token.lifetime
  refresh_token_window_minutes   = each.value.refresh_token.window


  ## Inline Hook
  inline_hook_id = each.value.inline_hook
}
