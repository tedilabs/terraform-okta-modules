mock_provider "okta" {}

run "maps_granular_authentication_methods" {
  command = plan

  variables {
    name = "test"
    rules = [{
      name = "default"
      verification = {
        constraints = [
          {
            possession = {
              authentication_methods = [{
                key    = "okta_verify"
                method = "signed_nonce"
              }]
            }
          },
          {
            knowledge = {
              excluded_authentication_methods = [{
                key = "okta_password"
              }]
            }
          },
        ]
      }
    }]
  }

  assert {
    condition = output.rules["default"].verification.constraints[0].possession.authentication_methods == toset([{
      id     = null
      key    = "okta_verify"
      method = "signed_nonce"
    }])
    error_message = "Possession authentication methods didn't round-trip through the API JSON representation."
  }

  assert {
    condition     = output.rules["default"].verification.constraints[0].possession.required == true
    error_message = "A constraint without excluded authentication methods must default required to true."
  }

  assert {
    condition     = output.rules["default"].verification.constraints[1].knowledge.required == false
    error_message = "A constraint with excluded authentication methods must default required to false."
  }
}

run "rejects_required_with_excluded_authentication_methods" {
  command = plan

  variables {
    name = "test"
    rules = [{
      name = "default"
      verification = {
        constraints = [{
          possession = {
            required = true
            excluded_authentication_methods = [{
              key = "phone_number"
            }]
          }
        }]
      }
    }]
  }

  expect_failures = [
    var.rules,
  ]
}

run "rejects_allowlist_and_denylist_together" {
  command = plan

  variables {
    name = "test"
    rules = [{
      name = "default"
      verification = {
        constraints = [{
          possession = {
            authentication_methods = [{
              key = "okta_verify"
            }]
            excluded_authentication_methods = [{
              key = "phone_number"
            }]
          }
        }]
      }
    }]
  }

  expect_failures = [
    var.rules,
  ]
}
