variable "name" {
  description = "(Required) The label of the Okta bookmark application. The application's display name."
  type        = string
  nullable    = false
}

variable "url" {
  description = "(Required) The URL of the Okta bookmark application."
  type        = string
  nullable    = false
}

variable "logo_path" {
  description = "(Optional) A local file path to the logo. The file must be in PNG, JPG, or GIF format, and less than 1 MB in size."
  type        = string
  default     = null
  nullable    = true
}

variable "enabled" {
  description = "(Optional) Whether to enable the Okta bookmark application. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "sign_on" {
  description = <<EOF
  (Optional) A configurations for application sign-on. `sign_on` block as defined below.
    (Optional) `authentication_policy` - The ID of the authentication policy to associate to the applicatioauthentication policy to associate to the application. If this is removed from the application the default sign-on-policy will be associated with this application.
  EOF
  type = object({
    authentication_policy = optional(string)
  })
  default  = {}
  nullable = false
}

variable "notes" {
  description = <<EOF
  (Optional) A configurations for application notes. `notes` block as defined below.
    (Optional) `admin` - Application notes for admins.
    (Optional) `user` - Application notes for end users.
  EOF
  type = object({
    admin = optional(string, "")
    user  = optional(string, "")
  })
  default  = {}
  nullable = false
}

# variable "self_service_enabled" {
#   description = "(Optional) Whether to enable self-service. Defaults to `false`."
#   default     = false
#   type        = bool
#   nullable    = false
# }

variable "custom_error_page" {
  description = "(Optional) The URL for custom error page."
  type        = string
  default     = null
  nullable    = true
}

variable "hide_app_on_ios" {
  description = "(Optional) Whether to hide application icon on mobile app. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "hide_app_on_web" {
  description = "(Optional) Whether to hide application icon on web. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "group_assignments" {
  description = <<EOF
  (Optional) A configurations to assign groups for the Okta bookmark application. Each item of `group_assignments` block as defined below.
    (Required) `group` - The ID of the group to assign.
    (Optional) `priority` - A priority of group assignment
    (Optional) `profile` - JSON document containing application profile.
  EOF
  type = list(object({
    group    = string
    priority = optional(number)
    profile  = optional(map(string), {})
  }))
  default  = []
  nullable = false
}
