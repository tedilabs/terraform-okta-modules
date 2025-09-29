terraform {
  required_version = ">= 1.12"

  required_providers {
    okta = {
      source  = "okta/okta"
      version = ">= 6.0"
    }
  }
}
