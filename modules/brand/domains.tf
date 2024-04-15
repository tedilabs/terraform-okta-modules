###################################################
# Custom Domains
###################################################

resource "okta_domain" "this" {
  for_each = {
    for domain in var.custom_domains :
    domain.name => domain
  }

  brand_id = okta_brand.this.id

  name                    = each.key
  certificate_source_type = each.value.type
}
