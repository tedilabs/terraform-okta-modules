variable "username" {
  description = "(Required) Unique identifier for the user."
  type        = string
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

# variable "enabled" {
#   description = "(Optional) Whether the user is enabled. Defaults to `true`."
#   type        = bool
#   default     = true
#   nullable    = false
# }
#
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
