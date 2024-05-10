variable "name" {
  description = "(Required) A name of the Okta Global Session Policy."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) A description of the Okta Global Session Policy."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "enabled" {
  description = "(Optional) Whether to enable the Okta Global Session Policy. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "priority" {
  description = "(Optional) A priority of the Okta Global Session Policy."
  type        = number
  default     = null
  nullable    = true
}

variable "groups" {
  description = "(Optional) A set of group IDs to assign the Okta Global Session Policy to."
  type        = set(string)
  default     = []
  nullable    = false
}
