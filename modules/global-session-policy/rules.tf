###################################################
# Rules of Okta Global Session Policy
###################################################

# TODO:
# identity_provider_ids (List of String) When identity_provider is SPECIFIC_IDP then this is the list of IdP IDs to apply the rule on
# INFO: Not supported attributes
# - `behaviors`
# INFO: Deprecated attributes
# - `risc_level`
# - `risk_level`
# - `factor_sequence`
resource "okta_policy_rule_signon" "this" {
  for_each = {
    for rule in var.rules :
    rule.name => rule
  }

  policy_id = okta_policy_signon.this.id

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

  authtype          = each.value.condition.authentication.entrypoint
  identity_provider = each.value.condition.authentication.identity_provider

  risc_level = ""
  risk_level = ""


  ## Effects
  access = each.value.allow_access ? "ALLOW" : "DENY"

  primary_factor = each.value.primary_factor

  mfa_required = each.value.mfa.required
  mfa_prompt   = each.value.mfa.prompt_mode
  mfa_lifetime = (each.value.mfa.required && each.value.mfa.prompt_mode == "SESSION"
    ? each.value.mfa.session_duration
    : 0
  )
  mfa_remember_device = each.value.mfa.remember_device_by_default

  session_lifetime   = each.value.session.duration
  session_idle       = each.value.session.idle_timeout
  session_persistent = each.value.session.persistent_cookie_enabled
}
