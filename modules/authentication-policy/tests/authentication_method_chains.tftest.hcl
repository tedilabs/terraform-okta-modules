mock_provider "okta" {}

run "maps_ordered_authentication_method_chains" {
  command = plan

  variables {
    name = "test"
    rules = [{
      name = "default"
      verification = {
        type = "AUTH_METHOD_CHAIN"
        chains = [
          {
            steps = [
              {
                authentication_methods = [{
                  key                       = "okta_verify"
                  method                    = "signed_nonce"
                  phishing_resistant        = "REQUIRED"
                  user_verification         = "REQUIRED"
                  user_verification_methods = ["BIOMETRICS"]
                }]
                reauthentication_timeout = "PT12H"
              },
              {
                authentication_methods = [{
                  key    = "okta_password"
                  method = "password"
                }]
              },
            ]
          },
          {
            steps = [{
              authentication_methods = [{
                id     = "autenticator-id"
                key    = "webauthn"
                method = "webauthn"
              }]
            }]
          },
        ]
      }
    }]
  }

  assert {
    condition     = output.rules["default"].verification.factor_mode == null
    error_message = "AUTH_METHOD_CHAIN must omit the assurance-only factor mode."
  }

  assert {
    condition     = output.rules["default"].verification.reauthentication_timeout == null
    error_message = "A step timeout must omit the verification-level timeout."
  }

  assert {
    condition     = length(output.rules["default"].verification.chains) == 2
    error_message = "Alternative authentication method chains didn't round-trip."
  }

  assert {
    condition     = one(output.rules["default"].verification.chains[0].steps[0].authentication_methods).phishing_resistant == "REQUIRED"
    error_message = "Authentication method requirements didn't round-trip."
  }

  assert {
    condition     = one(output.rules["default"].verification.chains[0].steps[1].authentication_methods).key == "okta_password"
    error_message = "Ordered authentication method chain steps didn't round-trip."
  }
}

run "rejects_assurance_fields_for_authentication_method_chain" {
  command = plan

  variables {
    name = "test"
    rules = [{
      name = "default"
      verification = {
        type = "AUTH_METHOD_CHAIN"
        constraints = [{
          possession = {}
        }]
        chains = [{
          steps = [{
            authentication_methods = [{
              key    = "okta_verify"
              method = "signed_nonce"
            }]
          }]
        }]
      }
    }]
  }

  expect_failures = [
    var.rules,
  ]
}

run "rejects_more_than_three_chain_steps" {
  command = plan

  variables {
    name = "test"
    rules = [{
      name = "default"
      verification = {
        type = "AUTH_METHOD_CHAIN"
        chains = [{
          steps = [
            for index in range(4) : {
              authentication_methods = [{
                key    = "method-${index}"
                method = "method"
              }]
            }
          ]
        }]
      }
    }]
  }

  expect_failures = [
    var.rules,
  ]
}

run "rejects_conflicting_reauthentication_timeouts" {
  command = plan

  variables {
    name = "test"
    rules = [{
      name = "default"
      verification = {
        type                     = "AUTH_METHOD_CHAIN"
        reauthentication_timeout = "PT24H"
        chains = [{
          steps = [{
            authentication_methods = [{
              key    = "okta_verify"
              method = "signed_nonce"
            }]
            reauthentication_timeout = "PT12H"
          }]
        }]
      }
    }]
  }

  expect_failures = [
    var.rules,
  ]
}

run "rejects_verification_methods_without_required_verification" {
  command = plan

  variables {
    name = "test"
    rules = [{
      name = "default"
      verification = {
        type = "AUTH_METHOD_CHAIN"
        chains = [{
          steps = [{
            authentication_methods = [{
              key                       = "okta_verify"
              method                    = "signed_nonce"
              user_verification_methods = ["PIN"]
            }]
          }]
        }]
      }
    }]
  }

  expect_failures = [
    var.rules,
  ]
}
