# brand

This module creates following resources.

- `okta_brand`
- `okta_domain` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 6.5 |
| <a name="requirement_telemetry"></a> [telemetry](#requirement\_telemetry) | >= 0.2.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_okta"></a> [okta](#provider\_okta) | >= 6.5 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [okta_brand.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/brand) | resource |
| [okta_domain.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | (Required) A name of the brand. | `string` | n/a | yes |
| <a name="input_custom_domains"></a> [custom\_domains](#input\_custom\_domains) | (Optional) A list of configurations for the custom domains. Each block of `custom_domains` block as defined below.<br/>    (Required) `name` - The name of custom domain like `id.example.com`.<br/>    (Optional) `type` - The certificate source type that indicates whether the certificate is provided by the user or Okta. Valid values are `MANUAL` and `OKTA_MANAGED`. Defaults to `OKTA_MANAGED`. | <pre>list(object({<br/>    name = string<br/>    type = optional(string, "OKTA_MANAGED")<br/>  }))</pre> | `[]` | no |
| <a name="input_custom_privacy_policy"></a> [custom\_privacy\_policy](#input\_custom\_privacy\_policy) | (Optional) A configurations for the custom privacy policy of the brand. `custom_privacy_policy` block as defined below.<br/>    (Optional) `enabled` - Whether to use custom privacy policy. Defaults to `false`.<br/>    (Optional) `url` - The url of the custom privacy policy. | <pre>object({<br/>    enabled = optional(bool, false)<br/>    url     = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_locale"></a> [locale](#input\_locale) | (Optional) The preferred language for the brand. Specified as an IETF BCP 47 language tag. Defaults to `en`. | `string` | `"en"` | no |
| <a name="input_powered_by_okta"></a> [powered\_by\_okta](#input\_powered\_by\_okta) | (Optional) Whether "Powered by Okta" appears in any visible footers. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_telemetry"></a> [telemetry](#input\_telemetry) | (Optional) A configuration to collect telemetry data for the module. This is used to improve the module and its features. To send pseudonyms instead of identifying values such as the hostname and the Git remote, set `pseudonymization_enabled` to `true`. Pseudonyms are not anonymous; to keep data from being sent, disable its collector. The default configuration enables telemetry collection for machine, network, git, github, github actions, HCP Terraform, terraform, and toolchain. You can disable telemetry collection by setting `enabled` to `false`. `telemetry` block as defined below.<br/>    (Optional) `enabled` - Whether to enable telemetry collection. Default is `true`.<br/>    (Optional) `capture_machine` - Whether to capture machine information. Default is `true`.<br/>    (Optional) `capture_network` - Whether to capture network information. Default is `true`.<br/>    (Optional) `capture_git` - Whether to capture git information. Default is `true`.<br/>    (Optional) `capture_github` - Whether to capture GitHub information. Default is `true`.<br/>    (Optional) `capture_github_actions` - Whether to capture GitHub Actions information. Default is `true`.<br/>    (Optional) `capture_hcp_terraform` - Whether to capture HCP Terraform information. Default is `true`.<br/>    (Optional) `capture_terraform` - Whether to capture Terraform information. Default is `true`.<br/>    (Optional) `capture_toolchain` - Whether to capture toolchain information. Default is `true`.<br/>    (Optional) `pseudonymization_enabled` - Whether to enable pseudonymization of the captured data. Default is `false`. | <pre>object({<br/>    enabled = optional(bool, true)<br/><br/>    capture_machine        = optional(bool, true)<br/>    capture_network        = optional(bool, true)<br/>    capture_git            = optional(bool, true)<br/>    capture_github         = optional(bool, true)<br/>    capture_github_actions = optional(bool, true)<br/>    capture_hcp_terraform  = optional(bool, true)<br/>    capture_terraform      = optional(bool, true)<br/>    capture_toolchain      = optional(bool, true)<br/><br/>    pseudonymization_enabled = optional(bool, false)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_custom_domains"></a> [custom\_domains](#output\_custom\_domains) | The configurations for the custom domains of the brand. |
| <a name="output_custom_privacy_policy"></a> [custom\_privacy\_policy](#output\_custom\_privacy\_policy) | The configurations for the custom privacy policy. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the brand. |
| <a name="output_is_default"></a> [is\_default](#output\_is\_default) | Whether this brand is default or not. |
| <a name="output_locale"></a> [locale](#output\_locale) | The preferred language for the brand. |
| <a name="output_name"></a> [name](#output\_name) | The name of the brand. |
| <a name="output_powered_by_okta"></a> [powered\_by\_okta](#output\_powered\_by\_okta) | Whether "Powered by Okta" appears in any visible footers. Defaults to `false`. |
<!-- END_TF_DOCS -->
