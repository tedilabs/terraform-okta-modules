variable "name" {
  description = "(Required) The name of the Okta Group."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) The description of the Okta Group."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "custom_profile_attributes" {
  description = "(Optional) A map of custom profile attributes for group members."
  type        = any
  default     = {}
  nullable    = false
}

variable "admin_role_assignments" {
  description = <<EOF
  (Optional) A configurations for admin roles to assign to the Okta group. Each item of `admin_role_assignments` block as defined below.
    (Required) `admin_role` - The admin role assigned to the group. Valid values are `SUPER_ADMIN`, `ORG_ADMIN`, `APP_ADMIN`, `USER_ADMIN`, `HELP_DESK_ADMIN`, `READ_ONLY_ADMIN` , `MOBILE_ADMIN`, `API_ACCESS_MANAGEMENT_ADMIN`, `REPORT_ADMIN`, `GROUP_MEMBERSHIP_ADMIN`. `USER_ADMIN` is the Group Administrator.
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

variable "exclusive_membership_management_enabled" {
  description = "(Optional) Whether to enable exclusive management for members of the Okta group. This includes removal of group members which are not explicitly configured. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "members" {
  description = "(Optional) A set of Okta user IDs to be members of the Okta group."
  type        = set(string)
  default     = []
  nullable    = false
}
