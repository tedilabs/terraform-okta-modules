###################################################
# Okta Group Rule
###################################################

resource "okta_group_rule" "this" {
  name                  = var.name
  status                = var.enabled ? "ACTIVE" : "INACTIVE"
  remove_assigned_users = var.cascade_on_delete


  ## Condition
  expression_type  = "urn:okta:expression:1.0"
  expression_value = var.expression

  ## Action
  group_assignments = var.groups
  users_excluded    = var.excluded_users
}
