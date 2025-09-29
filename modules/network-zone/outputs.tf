output "id" {
  description = "The ID of the Network Zone."
  value       = okta_network_zone.this.id
}

output "name" {
  description = "The name of the Network Zone."
  value       = okta_network_zone.this.name
}

output "type" {
  description = "The type of the Network Zone."
  value       = okta_network_zone.this.type
}

output "enabled" {
  description = "Whether the Network Zone is enabled."
  value       = okta_network_zone.this.status == "ACTIVE"
}

output "access_block_enabled" {
  description = "Whether the Network Zone is used to block access."
  value       = okta_network_zone.this.usage == "BLOCKLIST"
}

output "ip_addresses" {
  description = "A set of IP addresses or CIDR blocks defining the static IPs in the Network Zone."
  value       = okta_network_zone.this.gateways
}

output "proxy_ip_addresses" {
  description = "A set of IP addresses or CIDR blocks for trusted proxies in the Network Zone."
  value       = okta_network_zone.this.proxies
}

output "dynamic_config" {
  description = "A configurations for dynamic network zones."
  value = {
    asns                             = okta_network_zone.this.asns
    locations_to_exclude             = okta_network_zone.this.dynamic_locations_exclude
    locations_to_include             = okta_network_zone.this.dynamic_locations
    ip_service_categories_to_exclude = okta_network_zone.this.ip_service_categories_exclude
    ip_service_categories_to_include = okta_network_zone.this.ip_service_categories_include
  }
}

# output "debug" {
#   value = {
#     for k, v in okta_network_zone.this :
#     k => v
#     if !contains(["id", "name", "type", "status", "gateways", "proxies", "asns", "dynamic_locations", "dynamic_locations_exclude", "ip_service_categories_include", "ip_service_categories_exclude"], k)
#   }
# }
