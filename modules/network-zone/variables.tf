variable "name" {
  description = "(Required) The name of the Network Zone."
  type        = string
  nullable    = false
}

variable "type" {
  description = "(Optional) The type of the Network Zone. Valid values are `STATIC`, `DYNAMIC`. Defaults to `STATIC`."
  type        = string
  default     = "STATIC"
  nullable    = false

  validation {
    condition     = contains(["STATIC", "DYNAMIC"], var.type)
    error_message = "Valid values for `type` are `STATIC`, `DYNAMIC`."
  }
}

variable "enabled" {
  description = "(Optional) Whether the Network Zone is enabled. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "access_block_enabled" {
  description = "(Optional) Whether the Network Zone is used to block access. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "ip_addresses" {
  description = "(Optional) A set of IP addresses or CIDR blocks defining the static IPs in the Network Zone. Required if `type` is `STATIC`."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition     = var.type == "STATIC" ? length(var.ip_addresses) > 0 : true
    error_message = "You must provide at least one IP address or CIDR block in `ip_addresses` when `type` is `STATIC`."
  }
}

variable "proxy_ip_addresses" {
  description = "(Optional) A set of IP addresses or CIDR blocks for trusted proxies in the Network Zone."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition     = var.type == "DYNAMIC" ? length(var.proxy_ip_addresses) == 0 : true
    error_message = "You cannot provide `proxy_ip_addresses` when `type` is `DYNAMIC`."
  }
}

variable "dynamic_config" {
  description = <<EOF
  (Optional) A configurations for dynamic network zones. Required if `type` is `DYNAMIC`. `dynamic_config` as defined below.
    (Optional) `asns` - A set of ASNs (Autonomous System Numbers) to include in the network zone.
    (Optional) `locations_to_exclude` - A set of locations to exclude from the network zone. Format code: countryCode OR countryCode-regionCode.
    (Optional) `locations_to_include` - A set of locations to include in the network zone. Format code: countryCode OR countryCode-regionCode.
    (Optional) `ip_service_categories_to_exclude` - A set of IP service categories to exclude from the network zone.
    (Optional) `ip_service_categories_to_include` - A set of IP service categories to include in the network zone.
  EOF
  type = object({
    asns                             = optional(set(number), [])
    locations_to_exclude             = optional(set(string), [])
    locations_to_include             = optional(set(string), [])
    ip_service_categories_to_exclude = optional(set(string), [])
    ip_service_categories_to_include = optional(set(string), [])
  })
  default  = {}
  nullable = false

  validation {
    condition = (var.type == "STATIC"
      ? alltrue([
        length(var.dynamic_config.asns) == 0,
        length(var.dynamic_config.locations_to_exclude) == 0,
        length(var.dynamic_config.locations_to_include) == 0,
        length(var.dynamic_config.ip_service_categories_to_exclude) == 0,
        length(var.dynamic_config.ip_service_categories_to_include) == 0,
      ])
      : true
    )
    error_message = "You cannot provide `dynamic_config` when `type` is `STATIC`."
  }
}
