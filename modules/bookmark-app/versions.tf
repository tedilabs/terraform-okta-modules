terraform {
  required_version = ">= 1.12"

  required_providers {
    okta = {
      source  = "okta/okta"
      version = ">= 6.5"
    }
    telemetry = {
      source  = "tedilabs/telemetry"
      version = ">= 0.2.0"
    }
  }
}
