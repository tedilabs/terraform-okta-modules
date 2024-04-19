output "id" {
  description = "The ID of the user."
  value       = okta_user.this.id
}

output "first_name" {
  description = "The first name of the user."
  value       = okta_user.this.first_name
}

output "middle_name" {
  description = "The middle name of the user."
  value       = okta_user.this.middle_name
}

output "last_name" {
  description = "The family name of the user."
  value       = okta_user.this.last_name
}

output "honorific_prefix" {
  description = "An honorific prefix preceding a name."
  value       = okta_user.this.honorific_prefix
}

output "honorific_suffix" {
  description = "An honorific suffix following a name."
  value       = okta_user.this.honorific_suffix
}

output "nick_name" {
  description = "The casual name of the user."
  value       = okta_user.this.nick_name
}

output "display_name" {
  description = "The display name of the user."
  value       = okta_user.this.display_name
}

output "email" {
  description = "The primary email address of the user."
  value       = okta_user.this.email
}

output "secondary_email" {
  description = "The secondary email address of the user."
  value       = okta_user.this.second_email
}

output "phone" {
  description = "The phone number of the user for the work."
  value       = okta_user.this.mobile_phone
}

output "primary_phone" {
  description = "The primary phone number of the user."
  value       = okta_user.this.primary_phone
}

output "profile_url" {
  description = "The URL of the user's online profile."
  value       = okta_user.this.profile_url
}

output "address_info" {
  description = "The address information of the user."
  value = {
    country_code   = okta_user.this.country_code
    state          = okta_user.this.state
    city           = okta_user.this.city
    street_address = okta_user.this.street_address
    postal_address = okta_user.this.postal_address
    zip_code       = okta_user.this.zip_code
  }
}

output "employee_number" {
  description = "The company-assigned unique identifier for the user."
  value       = okta_user.this.employee_number
}

output "title" {
  description = "The title of the user."
  value       = okta_user.this.title
}

output "manager" {
  description = "The manager information of the user."
  value = {
    id   = okta_user.this.manager_id
    name = okta_user.this.manager
  }
}

output "organization" {
  description = "The organization name of the user."
  value       = okta_user.this.organization
}

output "division" {
  description = "The division name of the user."
  value       = okta_user.this.division
}

output "department" {
  description = "The department name of the user."
  value       = okta_user.this.department
}

output "cost_center" {
  description = "The name of the cost center assigned to the user."
  value       = okta_user.this.cost_center
}

output "preferences" {
  description = "The configurations of the user preferences."
  value = {
    locale             = okta_user.this.locale
    timezone           = okta_user.this.timezone
    preferred_language = okta_user.this.preferred_language
  }
}

output "groups" {
  description = <<EOF
  The information for the group memberships of the user.
  EOF
  value = [
    for group in data.okta_group.this :
    group.name
  ]
}

output "admin_role_assignments" {
  description = "The configurations for admin roles assigned to the Okta user."
  value = {
    for assignment in var.admin_role_assignments :
    assignment.admin_role => {
      admin_role    = assignment.admin_role
      target_apps   = assignment.target_apps
      target_groups = assignment.target_groups
    }
  }
}

output "admin_role_notification_enabled" {
  description = "Whether to send the default Okta administrator emails."
  value       = var.admin_role_notification_enabled
}
