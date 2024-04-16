variable "name" {
  description = "(Required) The name of the Okta Group Rule."
  type        = string
  nullable    = false
}

variable "enabled" {
  description = "(Optional) Whether to enable the Okta Group Rule. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "cascade_on_delete" {
  description = "(Optional) Whether to remove users added by this rule from the assigned group after deleting this resource. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "expression" {
  description = "(Required) The Okta expression for Okta group rule."
  type        = string
  nullable    = false
}

variable "groups" {
  description = "(Optional) A set of group ids to assign the users to."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "excluded_users" {
  description = "(Optional) A set of user IDs that would be excluded when rules are processed."
  type        = set(string)
  default     = []
  nullable    = false
}
