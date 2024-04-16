# brand

This module creates following resources.

- `okta_brand`
- `okta_domain` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | >= 4.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_okta"></a> [okta](#provider\_okta) | 4.8.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [okta_brand.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/brand) | resource |
| [okta_domain.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) A name of the brand. | `string` | n/a | yes |
| <a name="input_custom_domains"></a> [custom\_domains](#input\_custom\_domains) | (Optional) A list of configurations for the custom domains. Each block of `custom_domains` block as defined below.<br>    (Required) `name` - The name of custom domain like `id.example.com`.<br>    (Optional) `type` - The certificate source type that indicates whether the certificate is provided by the user or Okta. Valid values are `MANUAL` and `OKTA_MANAGED`. Defaults to `OKTA_MANAGED`. | <pre>list(object({<br>    name = string<br>    type = optional(string, "OKTA_MANAGED")<br>  }))</pre> | `[]` | no |
| <a name="input_custom_privacy_policy"></a> [custom\_privacy\_policy](#input\_custom\_privacy\_policy) | (Optional) A configurations for the custom privacy policy of the brand. `custom_privacy_policy` block as defined below.<br>    (Optional) `enabled` - Whether to use custom privacy policy. Defaults to `false`.<br>    (Optional) `url` - The url of the custom privacy policy. | <pre>object({<br>    enabled = optional(bool, false)<br>    url     = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_locale"></a> [locale](#input\_locale) | (Optional) The preferred language for the brand. Specified as an IETF BCP 47 language tag. Defaults to `en`. | `string` | `"en"` | no |
| <a name="input_powered_by_okta"></a> [powered\_by\_okta](#input\_powered\_by\_okta) | (Optional) Whether "Powered by Okta" appears in any visible footers. Defaults to `false`. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_domains"></a> [custom\_domains](#output\_custom\_domains) | The configurations for the custom domains of the brand. |
| <a name="output_custom_privacy_policy"></a> [custom\_privacy\_policy](#output\_custom\_privacy\_policy) | The configurations for the custom privacy policy. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the brand. |
| <a name="output_is_default"></a> [is\_default](#output\_is\_default) | Whether this brand is default or not. |
| <a name="output_locale"></a> [locale](#output\_locale) | The preferred language for the brand. |
| <a name="output_name"></a> [name](#output\_name) | The name of the brand. |
| <a name="output_powered_by_okta"></a> [powered\_by\_okta](#output\_powered\_by\_okta) | Whether "Powered by Okta" appears in any visible footers. Defaults to `false`. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
