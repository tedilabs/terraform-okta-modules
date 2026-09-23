mock_provider "okta" {}

run "defaults_to_static_rotation" {
  command = plan

  variables {
    name = "test"
    type = "web"
  }

  assert {
    condition     = output.refresh_token.behavior == "STATIC"
    error_message = "The refresh token behavior must default to STATIC."
  }

  assert {
    condition     = output.refresh_token.rotation_grace_period == 0
    error_message = "The refresh token rotation grace period must default to 0."
  }
}

run "maps_refresh_token_configuration" {
  command = plan

  variables {
    name        = "test"
    type        = "web"
    grant_types = ["authorization_code", "refresh_token"]
    refresh_token = {
      behavior              = "ROTATE"
      rotation_grace_period = 30
    }
  }

  assert {
    condition     = output.refresh_token.behavior == "ROTATE"
    error_message = "The refresh token behavior didn't map to `refresh_token_rotation`."
  }

  assert {
    condition     = output.refresh_token.rotation_grace_period == 30
    error_message = "The refresh token rotation grace period didn't map to `refresh_token_leeway`."
  }
}

run "rejects_unknown_behavior" {
  command = plan

  variables {
    name = "test"
    type = "web"
    refresh_token = {
      behavior = "REUSE"
    }
  }

  expect_failures = [
    var.refresh_token,
  ]
}

run "rejects_negative_rotation_grace_period" {
  command = plan

  variables {
    name = "test"
    type = "web"
    refresh_token = {
      rotation_grace_period = -1
    }
  }

  expect_failures = [
    var.refresh_token,
  ]
}
