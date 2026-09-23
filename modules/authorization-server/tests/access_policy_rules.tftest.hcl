mock_provider "okta" {}

variables {
  name      = "test"
  audiences = ["api://test"]
}

run "creates_no_rules_by_default" {
  command = plan

  variables {
    access_policies = [{
      name     = "default"
      priority = 1
    }]
  }

  assert {
    condition     = length(okta_auth_server_policy_rule.this) == 0
    error_message = "An access policy without rules must not create any rule."
  }
}

run "keys_rules_by_policy_and_name" {
  command = plan

  variables {
    access_policies = [
      {
        name     = "default"
        priority = 1
        rules = [{
          name      = "allow"
          condition = { grant_types = ["authorization_code"] }
        }]
      },
      {
        name     = "service"
        priority = 2
        rules = [{
          name      = "allow"
          condition = { grant_types = ["client_credentials"] }
        }]
      },
    ]
  }

  assert {
    condition     = toset(keys(local.access_policy_rules)) == toset(["default/allow", "service/allow"])
    error_message = "Rules of different policies must not collide when they share a name."
  }
}

run "derives_priority_from_position" {
  command = plan

  variables {
    access_policies = [{
      name     = "default"
      priority = 1
      rules = [
        {
          name      = "first"
          condition = { grant_types = ["authorization_code"] }
        },
        {
          name      = "second"
          condition = { grant_types = ["authorization_code"] }
        },
        {
          name      = "explicit"
          priority  = 10
          condition = { grant_types = ["authorization_code"] }
        },
      ]
    }]
  }

  assert {
    condition     = local.access_policy_rules["default/first"].priority == 1
    error_message = "The first rule must default to priority 1."
  }

  assert {
    condition     = local.access_policy_rules["default/second"].priority == 2
    error_message = "The second rule must default to priority 2."
  }

  assert {
    condition     = local.access_policy_rules["default/explicit"].priority == 10
    error_message = "An explicit priority must win over the derived one."
  }
}

run "maps_rule_configuration" {
  command = plan

  variables {
    access_policies = [{
      name     = "default"
      priority = 1
      rules = [{
        name    = "allow"
        enabled = false
        condition = {
          grant_types     = ["authorization_code", "implicit"]
          scopes          = ["openid", "profile"]
          included_groups = ["00g1"]
          excluded_users  = ["00u1"]
        }
        access_token  = { lifetime = 30 }
        refresh_token = { window = 1440 }
        inline_hook   = "cal1"
      }]
    }]
  }

  assert {
    condition     = okta_auth_server_policy_rule.this["default/allow"].status == "INACTIVE"
    error_message = "A disabled rule must map to the INACTIVE status."
  }

  assert {
    condition     = okta_auth_server_policy_rule.this["default/allow"].grant_type_whitelist == toset(["authorization_code", "implicit"])
    error_message = "`condition.grant_types` didn't map to `grant_type_whitelist`."
  }

  assert {
    condition     = okta_auth_server_policy_rule.this["default/allow"].scope_whitelist == toset(["openid", "profile"])
    error_message = "`condition.scopes` didn't map to `scope_whitelist`."
  }

  assert {
    condition     = okta_auth_server_policy_rule.this["default/allow"].group_whitelist == toset(["00g1"])
    error_message = "`condition.included_groups` didn't map to `group_whitelist`."
  }

  assert {
    condition     = okta_auth_server_policy_rule.this["default/allow"].user_blacklist == toset(["00u1"])
    error_message = "`condition.excluded_users` didn't map to `user_blacklist`."
  }

  assert {
    condition     = okta_auth_server_policy_rule.this["default/allow"].access_token_lifetime_minutes == 30
    error_message = "`access_token.lifetime` didn't map to `access_token_lifetime_minutes`."
  }

  assert {
    condition     = okta_auth_server_policy_rule.this["default/allow"].refresh_token_window_minutes == 1440
    error_message = "`refresh_token.window` didn't map to `refresh_token_window_minutes`."
  }

  assert {
    condition     = okta_auth_server_policy_rule.this["default/allow"].inline_hook_id == "cal1"
    error_message = "`inline_hook` didn't map to `inline_hook_id`."
  }
}

run "defaults_to_everyone_and_all_scopes" {
  command = plan

  variables {
    access_policies = [{
      name     = "default"
      priority = 1
      rules = [{
        name      = "allow"
        condition = { grant_types = ["authorization_code"] }
      }]
    }]
  }

  assert {
    condition     = okta_auth_server_policy_rule.this["default/allow"].group_whitelist == toset(["EVERYONE"])
    error_message = "`condition.included_groups` must default to EVERYONE."
  }

  assert {
    condition     = okta_auth_server_policy_rule.this["default/allow"].scope_whitelist == toset(["*"])
    error_message = "`condition.scopes` must default to all scopes."
  }

  assert {
    condition     = okta_auth_server_policy_rule.this["default/allow"].access_token_lifetime_minutes == 60
    error_message = "`access_token.lifetime` must default to 60 minutes."
  }

  assert {
    condition     = okta_auth_server_policy_rule.this["default/allow"].refresh_token_window_minutes == 10080
    error_message = "`refresh_token.window` must default to 7 days."
  }
}

run "rejects_unknown_grant_type" {
  command = plan

  variables {
    access_policies = [{
      name     = "default"
      priority = 1
      rules = [{
        name      = "allow"
        condition = { grant_types = ["device_code"] }
      }]
    }]
  }

  expect_failures = [
    var.access_policies,
  ]
}

run "rejects_access_token_lifetime_out_of_range" {
  command = plan

  variables {
    access_policies = [{
      name     = "default"
      priority = 1
      rules = [{
        name         = "allow"
        condition    = { grant_types = ["authorization_code"] }
        access_token = { lifetime = 1441 }
      }]
    }]
  }

  expect_failures = [
    var.access_policies,
  ]
}

run "rejects_duplicate_rule_names_in_a_policy" {
  command = plan

  variables {
    access_policies = [{
      name     = "default"
      priority = 1
      rules = [
        {
          name      = "allow"
          condition = { grant_types = ["authorization_code"] }
        },
        {
          name      = "allow"
          condition = { grant_types = ["client_credentials"] }
        },
      ]
    }]
  }

  expect_failures = [
    var.access_policies,
  ]
}
