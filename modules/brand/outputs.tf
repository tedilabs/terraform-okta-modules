output "id" {
  description = "The ID of the brand."
  value       = okta_brand.this.id
}

output "name" {
  description = "The name of the brand."
  value       = okta_brand.this.name
}

output "is_default" {
  description = "Whether this brand is default or not."
  value       = okta_brand.this.is_default
}

output "locale" {
  description = "The preferred language for the brand."
  value       = okta_brand.this.locale
}

output "custom_privacy_policy" {
  description = "The configurations for the custom privacy policy."
  value = {
    enabled = var.custom_privacy_policy.enabled
    url     = var.custom_privacy_policy.url
  }
}

output "powered_by_okta" {
  description = <<EOF
  Whether "Powered by Okta" appears in any visible footers. Defaults to `false`.
  EOF
  value       = okta_brand.this.remove_powered_by_okta
}

output "custom_domains" {
  description = <<EOF
  The configurations for the custom domains of the brand.
  EOF
  value = {
    for name, domain in okta_domain.this :
    name => {
      id   = domain.id
      name = name
      type = domain.certificate_source_type
      validation = {
        status      = domain.validation_status
        dns_records = domain.dns_records
      }
    }
  }
}

# output "debug" {
#   description = <<EOF
#   The configurations for the team permissions.
#   EOF
#   value = {
#     for k, v in okta_brand.this :
#     k => v
#     if !contains(["name", "id", "is_default", "brand_id", "locale", "agree_to_custom_privacy_policy", "custom_privacy_policy_url", "remove_powered_by_okta"], k)
#   }
# }
