###################################################
# Rules of Okta Authenticator Enrollment Policy
###################################################

# INFO: Not supported attributes
# - `app_exclude`
# - `app_include`
resource "okta_policy_rule_mfa" "this" {
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

  network_connection = each.value.condition.network.scope
  network_excludes = (each.value.condition.network.scope == "ZONE"
    ? each.value.condition.network.excluded_zones
    : null
  )
  network_includes = (each.value.condition.network.scope == "ZONE"
    ? each.value.condition.network.included_zones
    : null
  )


  ## Effects
  enroll = each.value.enroll
}
