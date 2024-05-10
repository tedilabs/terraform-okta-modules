variable "name" {
  description = "(Required) A name of the Okta Authentication Policy."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) A description of the Okta Authentication Policy."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}
