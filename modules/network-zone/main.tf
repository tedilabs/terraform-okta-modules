locals {
  type = {
    STATIC  = "IP",
    DYNAMIC = "DYNAMIC_V2",
  }
}


###################################################
# Okta Network Zone
###################################################

# INFO: Not supported attributes
# - `dynamic_proxy_type`
resource "okta_network_zone" "this" {
  name   = var.name
  type   = local.type[var.type]
  usage  = var.access_block_enabled ? "BLOCKLIST" : "POLICY"
  status = var.enabled ? "ACTIVE" : "INACTIVE"



  ## Static
  gateways = var.type == "STATIC" ? var.ip_addresses : null
  proxies  = var.type == "STATIC" ? var.proxy_ip_addresses : null


  ## Dynamic
  asns = var.type == "DYNAMIC" ? var.dynamic_config.asns : null

  dynamic_locations_exclude = var.type == "DYNAMIC" ? var.dynamic_config.locations_to_exclude : null
  dynamic_locations         = var.type == "DYNAMIC" ? var.dynamic_config.locations_to_include : null

  ip_service_categories_exclude = var.type == "DYNAMIC" ? var.dynamic_config.ip_service_categories_to_exclude : null
  ip_service_categories_include = var.type == "DYNAMIC" ? var.dynamic_config.ip_service_categories_to_include : null
}
