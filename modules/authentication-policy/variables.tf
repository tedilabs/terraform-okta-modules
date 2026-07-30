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

variable "rules" {
  description = <<EOF
  (Optional) A configuration for rules of the Okta Authentication Policy. Each item of `rules` block as defined below.
    (Required) `name` - A name of the authentication policy rule.
    (Optional) `priority` - A priority of the authentication policy rule.
    (Optional) `enabled` - Whether to enable the authentication policy rule. Defaults to `true`.
    (Optional) `condition` - A condition of the authentication policy rule. `condition` block as defined below.
      (Optional) `excluded_users` - A set of user IDs to exclude.
      (Optional) `included_users` - A set of user IDs to include.
      (Optional) `excluded_groups` - A set of group IDs to exclude.
      (Optional) `included_groups` - A set of group IDs to include.
      (Optional) `excluded_user_types` - A set of user type IDs to exclude.
      (Optional) `included_user_types` - A set of user type IDs to include.
      (Optional) `network` - A configuration for network conditions.
        (Optional) `scope` - Valid values are `ANYWHERE`, `ON_NETWORK`, `OFF_NETWORK`, or `ZONE`. Defaults to `ANYWHERE`.
        (Optional) `excluded_zones` - A set of excluded network zone IDs.
        (Optional) `included_zones` - A set of included network zone IDs.
      (Optional) `device` - A configuration for device conditions.
        (Optional) `type` - The required device state. Valid values are `ANY`, `REGISTERED`, or `MANAGED`. `REGISTERED`
          requires an Okta-registered device, and `MANAGED` additionally requires device management. Defaults to `ANY`.
        (Optional) `assurance_policies` - A set of included device assurance policy IDs. A device type other than `ANY`
          is required when device assurance policies are configured.
      (Optional) `platform` - A configuration for platform conditions.
        (Optional) `included_os_types` - Operating systems to include by platform type.
          (Optional) `desktop` - A set of desktop operating systems.
          (Optional) `mobile` - A set of mobile operating systems.
          `ANDROID`, `ANY`, `CHROMEOS`, `IOS`, `MACOS`, `OTHER`, and `WINDOWS` map directly to the Okta OS type.
          Other values, including `LINUX`, map to the `OTHER` OS type and are passed as the Okta OS expression.
      (Optional) `risk_score` - A risk score condition. Valid values are `ANY`, `LOW`, `MEDIUM`, or `HIGH`.
        By default, the risk score condition isn't sent to Okta.
      (Optional) `expression` - An Okta Expression Language condition.
    (Optional) `allow_access` - Whether to allow access. Defaults to `true`.
    (Optional) `verification` - A configuration for authentication requirements.
      (Optional) `type` - The verification method type. Valid value is `ASSURANCE`, which verifies that the selected
        factor count and constraints are satisfied. The Okta API also defines `AUTH_METHOD_CHAIN`, which prompts for
        specific authentication methods in a configured sequence, but this module doesn't support it because
        authentication method chains aren't implemented. Defaults to `ASSURANCE`.
      (Optional) `factor_mode` - Valid values are `1FA` or `2FA`. Defaults to `2FA`.
      (Optional) `reauthentication_timeout` - The maximum authentication age after which the user must re-authenticate,
        regardless of activity, in ISO 8601 duration format. Maps to `verificationMethod.reauthenticateIn` in the Okta
        Policy API and `re_authentication_frequency` in the Terraform Provider. `PT0S` means every sign-in attempt and
        Okta uses `PT43800H` to represent once per active Okta global session. Defaults to `PT43800H`.
      (Optional) `inactivity_timeout` - The duration without authentication activity after which the user must
        re-authenticate, in ISO 8601 duration format. Maps to `verificationMethod.inactivityPeriod` in the Okta Policy
        API and `inactivity_period` in the Terraform Provider. By default, no inactivity-based re-authentication is
        configured.
      (Optional) `constraints` - Knowledge and possession factor constraints.
        (Optional) `knowledge` - Requirements for knowledge factors, such as a password.
          (Optional) `required` - Whether a knowledge factor is required. Defaults to `true`.
          (Optional) `types` - Permitted knowledge authenticator types. Valid values are `SECURITY_KEY`, `PHONE`,
            `EMAIL`, `PASSWORD`, `SECURITY_QUESTION`, `APP`, or `FEDERATED`. Values are mapped to lowercase when passed
            to the Okta Policy API.
          (Optional) `reauthentication_timeout` - The maximum authentication age for the knowledge factor, in ISO 8601
            duration format. Maps to `knowledge.reauthenticateIn` in the Okta Policy API and overrides the verification
            method's `reauthenticateIn` interval for this factor.
        (Optional) `possession` - Requirements for possession factors, such as Okta Verify or a security key.
          (Optional) `required` - Whether a possession factor is required. Defaults to `true`.
          (Optional) `device_bound` - Whether the factor must be bound to a device. Valid values are `OPTIONAL` or
            `REQUIRED`. Defaults to `OPTIONAL`.
          (Optional) `hardware_protection` - Whether authentication secrets or private keys must be hardware-protected
            and non-exportable. Valid values are `OPTIONAL` or `REQUIRED`. Defaults to `OPTIONAL`.
          (Optional) `phishing_resistant` - Whether the factor must resist credential phishing. Valid values are
            `OPTIONAL` or `REQUIRED`. Defaults to `OPTIONAL`.
          (Optional) `user_presence` - Whether the user must approve an Okta Verify prompt or provide biometrics.
            Valid values are `OPTIONAL` or `REQUIRED`. Defaults to `REQUIRED`.
          (Optional) `user_verification` - Whether the factor must verify the user with an interaction such as a PIN or
            biometrics. Valid values are `OPTIONAL` or `REQUIRED`. Defaults to `OPTIONAL`.
          (Optional) `reauthentication_timeout` - The maximum authentication age for the possession factor, in ISO 8601
            duration format. Maps to `possession.reauthenticateIn` in the Okta Policy API and overrides the verification
            method's `reauthenticateIn` interval for this factor.
    (Optional) `keep_me_signed_in` - A configuration for the post-authentication Keep Me Signed In prompt.
      (Optional) `enabled` - Whether to allow the post-authentication prompt. Defaults to `false`.
      (Optional) `prompt_frequency` - How often the prompt is presented, in ISO 8601 duration format. Maps to
        `post_auth_prompt_frequency` in the Terraform Provider. Defaults to `PT168H` (7 days).
  EOF
  type = list(object({
    name     = string
    priority = optional(number)
    enabled  = optional(bool, true)

    condition = optional(object({
      excluded_users      = optional(set(string), [])
      included_users      = optional(set(string), [])
      excluded_groups     = optional(set(string), [])
      included_groups     = optional(set(string), [])
      excluded_user_types = optional(set(string), [])
      included_user_types = optional(set(string), [])
      network = optional(object({
        scope          = optional(string, "ANYWHERE")
        excluded_zones = optional(set(string), [])
        included_zones = optional(set(string), [])
      }), {})
      device = optional(object({
        type               = optional(string, "ANY")
        assurance_policies = optional(set(string), [])
      }), {})
      platform = optional(object({
        included_os_types = optional(object({
          desktop = optional(set(string), [])
          mobile  = optional(set(string), [])
        }), {})
      }), {})
      risk_score = optional(string)
      expression = optional(string)
    }), {})

    allow_access = optional(bool, true)
    verification = optional(object({
      type                     = optional(string, "ASSURANCE")
      factor_mode              = optional(string, "2FA")
      reauthentication_timeout = optional(string, "PT43800H")
      inactivity_timeout       = optional(string)
      constraints = optional(list(object({
        knowledge = optional(object({
          required                 = optional(bool, true)
          types                    = optional(set(string), [])
          reauthentication_timeout = optional(string)
        }))
        possession = optional(object({
          required                 = optional(bool, true)
          device_bound             = optional(string, "OPTIONAL")
          hardware_protection      = optional(string, "OPTIONAL")
          phishing_resistant       = optional(string, "OPTIONAL")
          user_presence            = optional(string, "REQUIRED")
          user_verification        = optional(string, "OPTIONAL")
          reauthentication_timeout = optional(string)
        }))
      })), [])
    }), {})
    keep_me_signed_in = optional(object({
      enabled          = optional(bool, false)
      prompt_frequency = optional(string, "PT168H")
    }), {})
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["ANYWHERE", "ON_NETWORK", "OFF_NETWORK", "ZONE"], rule.condition.network.scope)
    ])
    error_message = "Valid values for `condition.network.scope` are `ANYWHERE`, `ON_NETWORK`, `OFF_NETWORK`, or `ZONE`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["ANY", "REGISTERED", "MANAGED"], rule.condition.device.type)
    ])
    error_message = "Valid values for `condition.device.type` are `ANY`, `REGISTERED`, or `MANAGED`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      length(rule.condition.device.assurance_policies) == 0 || rule.condition.device.type != "ANY"
    ])
    error_message = "`condition.device.type` must be `REGISTERED` or `MANAGED` when `condition.device.assurance_policies` is configured."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      rule.condition.risk_score == null ? true : contains(["ANY", "LOW", "MEDIUM", "HIGH"], rule.condition.risk_score)
    ])
    error_message = "Valid values for `condition.risk_score` are `ANY`, `LOW`, `MEDIUM`, or `HIGH`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["1FA", "2FA"], rule.verification.factor_mode)
    ])
    error_message = "Valid values for `verification.factor_mode` are `1FA` or `2FA`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["ASSURANCE"], rule.verification.type)
    ])
    error_message = "Valid value for `verification.type` is `ASSURANCE`. `AUTH_METHOD_CHAIN` isn't supported because authentication method chains aren't implemented by this module."
  }
  validation {
    condition = alltrue(flatten([
      for rule in var.rules : [
        for constraint in rule.verification.constraints :
        constraint.knowledge == null || alltrue([
          for type in constraint.knowledge.types :
          contains(["SECURITY_KEY", "PHONE", "EMAIL", "PASSWORD", "SECURITY_QUESTION", "APP", "FEDERATED"], type)
        ])
      ]
    ]))
    error_message = "Valid values for knowledge constraint `types` are `SECURITY_KEY`, `PHONE`, `EMAIL`, `PASSWORD`, `SECURITY_QUESTION`, `APP`, or `FEDERATED`."
  }
  validation {
    condition = alltrue(flatten([
      for rule in var.rules : [
        for constraint in rule.verification.constraints :
        constraint.possession == null || alltrue([
          for value in [
            constraint.possession.device_bound,
            constraint.possession.hardware_protection,
            constraint.possession.phishing_resistant,
            constraint.possession.user_presence,
            constraint.possession.user_verification,
          ] :
          contains(["OPTIONAL", "REQUIRED"], value)
        ])
      ]
    ]))
    error_message = "Possession constraint values must be `OPTIONAL` or `REQUIRED`."
  }
}
