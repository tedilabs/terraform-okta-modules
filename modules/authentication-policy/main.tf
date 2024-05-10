###################################################
# Okta Authentication Policy
###################################################

resource "okta_app_signon_policy" "this" {
  name        = var.name
  description = var.description
}
