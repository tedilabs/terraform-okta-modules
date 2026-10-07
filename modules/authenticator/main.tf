locals {
  metadata = {
    package = "terraform-okta-modules"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
}


###################################################
# Authenticator (Factor)
###################################################

# INFO: Not supported attributes
# - `legacy_ignore_name`
resource "okta_authenticator" "this" {
  name   = var.name
  key    = lower(var.type)
  status = var.enabled ? "ACTIVE" : "INACTIVE"

  settings = var.settings != null ? jsonencode(var.settings) : null
}
