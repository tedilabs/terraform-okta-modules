###################################################
# Okta Global Session Policy
###################################################

resource "okta_policy_signon" "this" {
  name        = var.name
  description = var.description
  status      = var.enabled ? "ACTIVE" : "INACTIVE"

  priority        = var.priority
  groups_included = var.groups
}

data "okta_group" "this" {
  for_each = toset(okta_policy_signon.this.groups_included)

  id = each.value
}
