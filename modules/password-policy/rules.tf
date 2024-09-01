###################################################
# Rules of Okta Password Policy
###################################################

resource "okta_policy_rule_password" "this" {

  for_each = {
    for rule in var.rules :
    rule.name => rule
  }

  policy_id = local.policy.id

  name     = each.key
  priority = each.value.priority
  status   = each.value.enabled ? "ACTIVE" : "INACTIVE"


  ## Conditions
  users_excluded = each.value.condition.excluded_users

  network_connection = anytrue([
    length(each.value.condition.network.excluded_zones) > 0,
    length(each.value.condition.network.included_zones) > 0,
  ]) ? "ZONE" : "ANYWHERE"
  network_excludes = (length(each.value.condition.network.excluded_zones) > 0
    ? each.value.condition.network.excluded_zones
    : null
  )
  network_includes = (length(each.value.condition.network.included_zones) > 0
    ? each.value.condition.network.included_zones
    : null
  )


  ## Effects
  password_change = each.value.allow_password_change ? "ALLOW" : "DENY"
  password_reset  = each.value.allow_password_reset ? "ALLOW" : "DENY"
  password_unlock = each.value.allow_password_unlock ? "ALLOW" : "DENY"
}
