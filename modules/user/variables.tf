variable "username" {
  description = "(Required) Unique identifier for the user."
  type        = string
  nullable    = false
}

variable "admin_role_assignments" {
  description = <<EOF
  (Optional) A configurations for admin roles to assign to the Okta user. Each item of `admin_role_assignments` block as defined below.
    (Required) `admin_role` - The admin role assigned to the user. Valid values are `SUPER_ADMIN`, `ORG_ADMIN`, `APP_ADMIN`, `USER_ADMIN`, `HELP_DESK_ADMIN`, `READ_ONLY_ADMIN` , `MOBILE_ADMIN`, `API_ACCESS_MANAGEMENT_ADMIN`, `REPORT_ADMIN`, `GROUP_MEMBERSHIP_ADMIN`. `USER_ADMIN` is the Group Administrator.
    (Optional) `target_apps` - A list of app names (name represents set of app instances, like `salesforce` or `facebook`), or a combination of app name and app instance ID (like `facebook.0oapsqQ6dv19pqyEo0g3`) you would like as the targets of the admin role. Only supported when used with the role type `APP_ADMIN`.
    (Optional) `target_groups` - A list of group IDs you would like as the targets of the admin role. Only supported when used with the role types: `GROUP_MEMBERSHIP_ADMIN`, `HELP_DESK_ADMIN`, or `USER_ADMIN`.
  EOF
  type = list(object({
    admin_role    = string
    target_apps   = optional(set(string), [])
    target_groups = optional(set(string), [])
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for assignment in var.admin_role_assignments :
      contains(["SUPER_ADMIN", "ORG_ADMIN", "APP_ADMIN", "USER_ADMIN", "HELP_DESK_ADMIN", "READ_ONLY_ADMIN", "MOBILE_ADMIN", "API_ACCESS_MANAGEMENT_ADMIN", "REPORT_ADMIN", "GROUP_MEMBERSHIP_ADMIN"], assignment.admin_role)
    ])
    error_message = "Valid values for `admin_role` are `SUPER_ADMIN`, `ORG_ADMIN`, `APP_ADMIN`, `USER_ADMIN`, `HELP_DESK_ADMIN`, `READ_ONLY_ADMIN`, `MOBILE_ADMIN`, `API_ACCESS_MANAGEMENT_ADMIN`, `REPORT_ADMIN`, `GROUP_MEMBERSHIP_ADMIN`."
  }
}

variable "admin_role_notification_enabled" {
  description = "(Optional) Whether to send the default Okta administrator emails. When this setting is disabled, the admins won't receive any of the notifications. These admins also won't have access to contact Okta Support and open support cases on behalf of your org. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "groups" {
  description = <<EOF
  (Optional) A set of group IDs for the group memberships of the user.
  EOF
  type        = set(string)
  default     = []
  nullable    = false
}

variable "status" {
  description = "(Optional) A status of the user account which provides information about the user account and whether administrative or user action is required. Valid values are `STAGED`, `ACTIVE`, `SUSPENDED`, `DEPROVISIONED`. Defaults to `ACTIVE`."
  type        = string
  default     = "ACTIVE"
  nullable    = false

  validation {
    condition     = contains(["STAGED", "ACTIVE", "SUSPENDED", "DEPROVISIONED"], var.status)
    error_message = "Valid values for `status` are `STAGED`, `ACTIVE`, `SUSPENDED`, `DEPROVISIONED`."
  }
}

variable "first_name" {
  description = "(Required) A given name of the user."
  type        = string
  nullable    = false
}

variable "middle_name" {
  description = "(Optional) A middle name of the user."
  type        = string
  default     = null
  nullable    = true
}

variable "last_name" {
  description = "(Required) A family name of the user."
  type        = string
  nullable    = false
}

variable "honorific_prefix" {
  description = "(Optional) An honorific prefix preceding a name such as Dr/Mrs/Mr."
  type        = string
  default     = null
  nullable    = true
}

variable "honorific_suffix" {
  description = "(Optional) An honorific suffix following a name such as M.D./PhD/MSCSW."
  type        = string
  default     = null
  nullable    = true
}

variable "nick_name" {
  description = "(Optional) A casual name to address the user."
  type        = string
  default     = null
  nullable    = true
}

variable "display_name" {
  description = "(Optional) A name of the user, suitable to display to end users."
  type        = string
  default     = null
  nullable    = true
}

variable "email" {
  description = "(Required) A primary email address for the user."
  type        = string
  nullable    = false
}

variable "secondary_email" {
  description = "(Required) A secondary email address for the user. Typically used for account recovery."
  type        = string
  nullable    = false
}

variable "phone" {
  description = "(Required) A phone number of the user for the work."
  type        = string
  nullable    = false
}

variable "primary_phone" {
  description = "(Optional) A primary phone number of the user such as home number."
  type        = string
  default     = null
  nullable    = true
}

variable "profile_url" {
  description = "(Optional) The URL of the user's online profile."
  type        = string
  default     = null
  nullable    = true
}

variable "address_info" {
  description = <<EOF
  (Optional) A configuration for the user address. `address_info` block as defined below.
    (Optional) `country_code` - A country code of the user address. Formatted with ISO 3166-1
    alpha 2 code.
    (Optional) `state` - A state or region of the user address.
    (Optional) `city` - A city or locality of the user address.
    (Optional) `street_address` - A full street address of the user address.
    (Optional) `postal_address` - A mailing address of the user address.
    (Optional) `zip_code` - A postal code of the user address.
  EOF
  type = object({
    country_code   = optional(string)
    state          = optional(string)
    city           = optional(string)
    street_address = optional(string)
    postal_address = optional(string)
    zip_code       = optional(string)
  })
  default  = {}
  nullable = false
}

variable "employee_number" {
  description = "(Optional) A company-assigned unique identifier for the user."
  type        = string
  default     = null
  nullable    = true
}

variable "title" {
  description = <<EOF
  (Optional) A title of the user like "Vice President".
  EOF
  type        = string
  default     = null
  nullable    = true
}

variable "manager" {
  description = <<EOF
  (Optional) A configuration for the user's manager. `manager` block as defined below.
    (Optional) `id` - The ID of the user's manager.
    (Optional) `name` - The `display_name` of the user's manager.
  EOF
  type = object({
    id   = optional(string)
    name = optional(string)
  })
  default  = {}
  nullable = false
}

variable "organization" {
  description = "(Optional) The organization name of the user."
  type        = string
  default     = null
  nullable    = true
}

variable "division" {
  description = "(Optional) The division name of the user."
  type        = string
  default     = null
  nullable    = true
}

variable "department" {
  description = "(Optional) The department name of the user."
  type        = string
  default     = null
  nullable    = true
}

variable "cost_center" {
  description = "(Optional) A name of the cost center assigned to the user."
  type        = string
  default     = null
  nullable    = true
}

variable "custom_attributes" {
  description = "(Optional) The object for custom profile attributes of the user."
  type        = any
  default     = {}
  nullable    = false
}

variable "custom_attributes_to_ignore" {
  description = "(Optional) A set of custom attribute keys that should be excluded from being managed by Terraform. This is useful in situations where specific custom fields may contain sensitive information and should be managed outside of Terraform."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "locale" {
  description = "(Optional) A locale value is a concatenation of the ISO 639-1 two-letter language code, an underscore, and the ISO 3166-1 two-letter country code. For example, `en_US` specifies the language English and country US. Defaults to `en_US`."
  type        = string
  default     = "en_US"
  nullable    = false
}

variable "timezone" {
  description = "(Optional) A time zone of the user like `Asia/Seoul`."
  type        = string
  default     = null
  nullable    = true
}

variable "preferred_language" {
  description = "(Optional) A preferred written or spoken languages of the user. Formatted with RFC 7231."
  type        = string
  default     = null
  nullable    = true
}
