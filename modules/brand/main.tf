locals {
  metadata = {
    package = "terraform-okta-modules"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  }
}


###################################################
# Okta Brand
###################################################

resource "okta_brand" "this" {
  name   = var.name
  locale = var.locale

  ## Custom Privacy Policy
  agree_to_custom_privacy_policy = (var.custom_privacy_policy.enabled
    ? true
    : null
  )
  custom_privacy_policy_url = (var.custom_privacy_policy.enabled
    ? var.custom_privacy_policy.url
    : null
  )

  remove_powered_by_okta = !var.powered_by_okta
}
