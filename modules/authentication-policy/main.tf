###################################################
# Okta Authentication Policy
###################################################

# INFO: Unimplemented attributes
# - `priority`
# - `catch_all`
resource "okta_app_signon_policy" "this" {
  name        = var.name
  description = var.description
}
