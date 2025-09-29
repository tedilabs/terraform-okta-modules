# network-zone

This module creates following resources.

- `okta_network_zone`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_okta"></a> [okta](#provider\_okta) | 6.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [okta_network_zone.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/network_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Network Zone. | `string` | n/a | yes |
| <a name="input_access_block_enabled"></a> [access\_block\_enabled](#input\_access\_block\_enabled) | (Optional) Whether the Network Zone is used to block access. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_dynamic_config"></a> [dynamic\_config](#input\_dynamic\_config) | (Optional) A configurations for dynamic network zones. Required if `type` is `DYNAMIC`. `dynamic_config` as defined below.<br/>    (Optional) `asns` - A set of ASNs (Autonomous System Numbers) to include in the network zone.<br/>    (Optional) `locations_to_exclude` - A set of locations to exclude from the network zone. Format code: countryCode OR countryCode-regionCode.<br/>    (Optional) `locations_to_include` - A set of locations to include in the network zone. Format code: countryCode OR countryCode-regionCode.<br/>    (Optional) `ip_service_categories_to_exclude` - A set of IP service categories to exclude from the network zone.<br/>    (Optional) `ip_service_categories_to_include` - A set of IP service categories to include in the network zone. | <pre>object({<br/>    asns                             = optional(set(number), [])<br/>    locations_to_exclude             = optional(set(string), [])<br/>    locations_to_include             = optional(set(string), [])<br/>    ip_service_categories_to_exclude = optional(set(string), [])<br/>    ip_service_categories_to_include = optional(set(string), [])<br/>  })</pre> | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether the Network Zone is enabled. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_ip_addresses"></a> [ip\_addresses](#input\_ip\_addresses) | (Optional) A set of IP addresses or CIDR blocks defining the static IPs in the Network Zone. Required if `type` is `STATIC`. | `set(string)` | `[]` | no |
| <a name="input_proxy_ip_addresses"></a> [proxy\_ip\_addresses](#input\_proxy\_ip\_addresses) | (Optional) A set of IP addresses or CIDR blocks for trusted proxies in the Network Zone. | `set(string)` | `[]` | no |
| <a name="input_type"></a> [type](#input\_type) | (Optional) The type of the Network Zone. Valid values are `STATIC`, `DYNAMIC`. Defaults to `STATIC`. | `string` | `"STATIC"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_block_enabled"></a> [access\_block\_enabled](#output\_access\_block\_enabled) | Whether the Network Zone is used to block access. |
| <a name="output_dynamic_config"></a> [dynamic\_config](#output\_dynamic\_config) | A configurations for dynamic network zones. |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether the Network Zone is enabled. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Network Zone. |
| <a name="output_ip_addresses"></a> [ip\_addresses](#output\_ip\_addresses) | A set of IP addresses or CIDR blocks defining the static IPs in the Network Zone. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Network Zone. |
| <a name="output_proxy_ip_addresses"></a> [proxy\_ip\_addresses](#output\_proxy\_ip\_addresses) | A set of IP addresses or CIDR blocks for trusted proxies in the Network Zone. |
| <a name="output_type"></a> [type](#output\_type) | The type of the Network Zone. |
<!-- END_TF_DOCS -->
