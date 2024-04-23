###################################################
# Authenticator (Factor)
###################################################

resource "okta_factor" "this" {
  provider_id = lower(var.type)
  active      = var.enabled
}
