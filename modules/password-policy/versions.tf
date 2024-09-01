terraform {
  required_version = ">= 1.8"

  required_providers {
    okta = {
      source  = "okta/okta"
      version = ">= 4.8"
    }
  }
}
