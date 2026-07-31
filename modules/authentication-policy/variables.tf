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
      (Optional) `type` - The verification method type. Valid values are `ASSURANCE`, which verifies that the selected
        factor count and constraints are satisfied, or `AUTH_METHOD_CHAIN`, which requires configured authentication
        methods in order. Defaults to `ASSURANCE`.
      (Optional) `factor_mode` - Valid values are `1FA` or `2FA`. Defaults to `2FA`.
      (Optional) `reauthentication_timeout` - The maximum authentication age after which the user must re-authenticate,
        regardless of activity, in ISO 8601 duration format. Maps to `verificationMethod.reauthenticateIn` in the Okta
        Policy API and `re_authentication_frequency` in the Terraform Provider. `PT0S` means every sign-in attempt and
        Okta uses `PT43800H` to represent once per active Okta global session. Defaults to `PT43800H` when no
        chain-step timeout is configured.
      (Optional) `inactivity_timeout` - The duration without authentication activity after which the user must
        re-authenticate, in ISO 8601 duration format. Maps to `verificationMethod.inactivityPeriod` in the Okta Policy
        API and `inactivity_period` in the Terraform Provider. By default, no inactivity-based re-authentication is
        configured.
      (Optional) `constraints` - Knowledge and possession factor constraints.
        (Optional) `knowledge` - Requirements for knowledge factors, such as a password.
          (Optional) `required` - Whether a knowledge factor is required. Defaults to `true`, or `false` when
            `excluded_authentication_methods` is configured.
          (Optional) `types` - Permitted knowledge authenticator types. Valid values are `SECURITY_KEY`, `PHONE`,
            `EMAIL`, `PASSWORD`, `SECURITY_QUESTION`, `APP`, or `FEDERATED`. Values are mapped to lowercase when passed
            to the Okta Policy API.
          (Optional) `authentication_methods` - Precise authenticator methods to allow. Each item requires `key` and
            optionally accepts `method` and the Limited GA `id`. Maps to `authenticationMethods` in the Okta Policy API.
          (Optional) `excluded_authentication_methods` - Precise authenticator methods to exclude. Uses the same item
            structure as `authentication_methods` and maps to `excludedAuthenticationMethods` in the Okta Policy API.
            The module sets `required` to `false` when this is configured, as required by the Okta Policy API.
          (Optional) `reauthentication_timeout` - The maximum authentication age for the knowledge factor, in ISO 8601
            duration format. Maps to `knowledge.reauthenticateIn` in the Okta Policy API and overrides the verification
            method's `reauthenticateIn` interval for this factor.
        (Optional) `possession` - Requirements for possession factors, such as Okta Verify or a security key.
          (Optional) `required` - Whether a possession factor is required. Defaults to `true`, or `false` when
            `excluded_authentication_methods` is configured.
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
          (Optional) `authentication_methods` - Precise authenticator methods to allow. Each item requires `key` and
            optionally accepts `method` and the Limited GA `id`. Maps to `authenticationMethods` in the Okta Policy API.
          (Optional) `excluded_authentication_methods` - Precise authenticator methods to exclude. Uses the same item
            structure as `authentication_methods` and maps to `excludedAuthenticationMethods` in the Okta Policy API.
            The module sets `required` to `false` when this is configured, as required by the Okta Policy API.
          (Optional) `reauthentication_timeout` - The maximum authentication age for the possession factor, in ISO 8601
            duration format. Maps to `possession.reauthenticateIn` in the Okta Policy API and overrides the verification
            method's `reauthenticateIn` interval for this factor.
      (Optional) `chains` - Ordered authentication method chains for `AUTH_METHOD_CHAIN`. A rule supports up to five
        alternative chains. Each chain is satisfied when its one to three steps are completed in order.
        (Required) `steps` - Ordered authentication steps. Methods within one step are alternatives.
          (Required) `authentication_methods` - Authentication methods accepted by this step. Each method requires the
            Okta authenticator `key` and `method`, and optionally accepts its `id`.
          (Optional) `hardware_protection` - Whether the method must use hardware-protected keys. Valid values are
            `OPTIONAL` or `REQUIRED`. Defaults to `OPTIONAL`.
          (Optional) `phishing_resistant` - Whether the method must be phishing-resistant. Valid values are `OPTIONAL`
            or `REQUIRED`. Defaults to `OPTIONAL`.
          (Optional) `user_verification` - Whether the method must verify the user locally. Valid values are `OPTIONAL`
            or `REQUIRED`. Defaults to `OPTIONAL`.
          (Optional) `user_verification_methods` - Permitted local verification methods. Valid values are `BIOMETRICS`
            or `PIN`, and may only be set when `user_verification` is `REQUIRED`.
          (Optional) `reauthentication_timeout` - Maximum authentication age for this step in ISO 8601 duration format.
            Maps to `AuthenticationMethodChain.reauthenticateIn`. It can't be combined with the verification-level
            `reauthentication_timeout`.
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
      reauthentication_timeout = optional(string)
      inactivity_timeout       = optional(string)
      constraints = optional(list(object({
        knowledge = optional(object({
          required = optional(bool)
          types    = optional(set(string), [])
          authentication_methods = optional(set(object({
            id     = optional(string)
            key    = string
            method = optional(string)
          })), [])
          excluded_authentication_methods = optional(set(object({
            id     = optional(string)
            key    = string
            method = optional(string)
          })), [])
          reauthentication_timeout = optional(string)
        }))
        possession = optional(object({
          required            = optional(bool)
          device_bound        = optional(string, "OPTIONAL")
          hardware_protection = optional(string, "OPTIONAL")
          phishing_resistant  = optional(string, "OPTIONAL")
          user_presence       = optional(string, "REQUIRED")
          user_verification   = optional(string, "OPTIONAL")
          authentication_methods = optional(set(object({
            id     = optional(string)
            key    = string
            method = optional(string)
          })), [])
          excluded_authentication_methods = optional(set(object({
            id     = optional(string)
            key    = string
            method = optional(string)
          })), [])
          reauthentication_timeout = optional(string)
        }))
      })), [])
      chains = optional(list(object({
        steps = list(object({
          authentication_methods = set(object({
            id                        = optional(string)
            key                       = string
            method                    = string
            hardware_protection       = optional(string, "OPTIONAL")
            phishing_resistant        = optional(string, "OPTIONAL")
            user_verification         = optional(string, "OPTIONAL")
            user_verification_methods = optional(set(string), [])
          }))
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
      rule.verification.type != "ASSURANCE" || contains(["1FA", "2FA"], rule.verification.factor_mode)
    ])
    error_message = "Valid values for `verification.factor_mode` are `1FA` or `2FA`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["ASSURANCE", "AUTH_METHOD_CHAIN"], rule.verification.type)
    ])
    error_message = "Valid values for `verification.type` are `ASSURANCE` or `AUTH_METHOD_CHAIN`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      rule.verification.type == "ASSURANCE" ? length(rule.verification.chains) == 0 : (
        length(rule.verification.constraints) == 0 &&
        length(rule.verification.chains) >= 1 &&
        length(rule.verification.chains) <= 5
      )
    ])
    error_message = "`ASSURANCE` uses `constraints` and can't use `chains`; `AUTH_METHOD_CHAIN` requires one to five `chains` and can't use `constraints`."
  }
  validation {
    condition = alltrue(flatten([
      for rule in var.rules : [
        for chain in rule.verification.chains :
        length(chain.steps) >= 1 && length(chain.steps) <= 3
      ]
    ]))
    error_message = "Each authentication method chain must contain one to three `steps`."
  }
  validation {
    condition = alltrue(flatten([
      for rule in var.rules : [
        for chain in rule.verification.chains : [
          for step in chain.steps :
          length(step.authentication_methods) >= 1
        ]
      ]
    ]))
    error_message = "Each authentication method chain step must contain at least one `authentication_methods` item."
  }
  validation {
    condition = alltrue(flatten([
      for rule in var.rules : [
        for chain in rule.verification.chains : [
          for step in chain.steps : [
            for method in step.authentication_methods :
            contains(["OPTIONAL", "REQUIRED"], method.hardware_protection) &&
            contains(["OPTIONAL", "REQUIRED"], method.phishing_resistant) &&
            contains(["OPTIONAL", "REQUIRED"], method.user_verification) &&
            alltrue([
              for verification_method in method.user_verification_methods :
              contains(["BIOMETRICS", "PIN"], verification_method)
            ]) &&
            (length(method.user_verification_methods) == 0 || method.user_verification == "REQUIRED")
          ]
        ]
      ]
    ]))
    error_message = "Chain method protection values must be `OPTIONAL` or `REQUIRED`; `user_verification_methods` accepts `BIOMETRICS` or `PIN` only when `user_verification` is `REQUIRED`."
  }
  validation {
    condition = alltrue([
      for rule in var.rules :
      rule.verification.reauthentication_timeout == null || !anytrue(flatten([
        for chain in rule.verification.chains : [
          for step in chain.steps :
          step.reauthentication_timeout != null
        ]
      ]))
    ])
    error_message = "Verification-level `reauthentication_timeout` can't be combined with a chain step `reauthentication_timeout`."
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
        constraint.knowledge == null ? true : (
          length(constraint.knowledge.authentication_methods) == 0 ||
          length(constraint.knowledge.excluded_authentication_methods) == 0
        )
      ]
    ]))
    error_message = "Only one of knowledge constraint `authentication_methods` or `excluded_authentication_methods` can be configured."
  }
  validation {
    condition = alltrue(flatten([
      for rule in var.rules : [
        for constraint in rule.verification.constraints :
        constraint.possession == null ? true : (
          length(constraint.possession.authentication_methods) == 0 ||
          length(constraint.possession.excluded_authentication_methods) == 0
        )
      ]
    ]))
    error_message = "Only one of possession constraint `authentication_methods` or `excluded_authentication_methods` can be configured."
  }
  validation {
    condition = alltrue(flatten([
      for rule in var.rules : [
        for constraint in rule.verification.constraints : [
          constraint.knowledge == null ? true : (
            length(constraint.knowledge.excluded_authentication_methods) == 0 ||
            constraint.knowledge.required != true
          ),
          constraint.possession == null ? true : (
            length(constraint.possession.excluded_authentication_methods) == 0 ||
            constraint.possession.required != true
          ),
        ]
      ]
    ]))
    error_message = "Constraint `required` can't be `true` when `excluded_authentication_methods` is configured."
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
