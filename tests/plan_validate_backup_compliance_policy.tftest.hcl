mock_provider "mongodbatlas" {}

variables {
  name   = "test-project"
  org_id = "000000000000000000000000"
}

run "bcp_null_no_submodule" {
  command = plan
  assert {
    condition     = length(module.backup_compliance_policy) == 0
    error_message = "Expected backup_compliance_policy submodule to be disabled when null"
  }
}

run "bcp_minimal" {
  command = plan
  variables {
    backup_compliance_policy = {
      authorized_email           = "security@example.com"
      authorized_user_first_name = "Jane"
      authorized_user_last_name  = "Doe"
    }
  }
  assert {
    condition     = length(module.backup_compliance_policy) == 1
    error_message = "Expected backup_compliance_policy submodule to be instantiated"
  }
  assert {
    condition     = length(output.backup_compliance_policy_items) == 5
    error_message = "Expected 5 default policy items (hourly, daily, weekly, monthly, yearly)"
  }
}

run "bcp_complete" {
  command = plan
  variables {
    backup_compliance_policy = {
      authorized_email           = "security@example.com"
      authorized_user_first_name = "Jane"
      authorized_user_last_name  = "Doe"

      copy_protection_enabled    = true
      encryption_at_rest_enabled = true
      pit_enabled                = true
      restore_window_days        = 7

      policy_items = [
        { frequency_type = "ondemand", frequency_interval = 1, retention_unit = "days", retention_value = 3 },
        { frequency_type = "hourly", frequency_interval = 6, retention_unit = "days", retention_value = 7 },
        { frequency_type = "daily", frequency_interval = 1, retention_unit = "days", retention_value = 7 },
        { frequency_type = "weekly", frequency_interval = 6, retention_unit = "weeks", retention_value = 4 },
        { frequency_type = "monthly", frequency_interval = 40, retention_unit = "months", retention_value = 12 },
        { frequency_type = "yearly", frequency_interval = 12, retention_unit = "years", retention_value = 1 },
      ]
    }
  }
  assert {
    condition     = length(module.backup_compliance_policy) == 1
    error_message = "Expected backup_compliance_policy submodule to be instantiated"
  }
  assert {
    condition     = length(output.backup_compliance_policy_items) == 6
    error_message = "Expected 6 policy items (ondemand, hourly, daily, weekly, monthly, yearly)"
  }
}

run "bcp_skip_default_policy_items" {
  command = plan
  variables {
    backup_compliance_policy = {
      authorized_email           = "security@example.com"
      authorized_user_first_name = "Jane"
      authorized_user_last_name  = "Doe"

      skip_default_policy_items = true
    }
  }
  assert {
    condition     = length(module.backup_compliance_policy) == 1
    error_message = "Expected backup_compliance_policy submodule to be instantiated"
  }
  assert {
    condition     = length(output.backup_compliance_policy_items) == 0
    error_message = "Expected 0 policy items when skip_default_policy_items is true and no policy_items are provided"
  }
}

run "bcp_invalid_frequency_type" {
  command = plan
  variables {
    backup_compliance_policy = {
      authorized_email           = "security@example.com"
      authorized_user_first_name = "Jane"
      authorized_user_last_name  = "Doe"
      policy_items = [
        { frequency_type = "invalid", frequency_interval = 1, retention_unit = "weeks", retention_value = 2 }
      ]
    }
  }
  expect_failures = [var.backup_compliance_policy]
}

run "bcp_duplicate_frequency_type" {
  command = plan
  variables {
    backup_compliance_policy = {
      authorized_email           = "security@example.com"
      authorized_user_first_name = "Jane"
      authorized_user_last_name  = "Doe"
      policy_items = [
        { frequency_type = "hourly", frequency_interval = 6, retention_unit = "days", retention_value = 7 },
        { frequency_type = "hourly", frequency_interval = 12, retention_unit = "days", retention_value = 3 },
      ]
    }
  }
  expect_failures = [var.backup_compliance_policy]
}

run "bcp_pit_without_restore_window" {
  command = plan
  variables {
    backup_compliance_policy = {
      authorized_email           = "security@example.com"
      authorized_user_first_name = "Jane"
      authorized_user_last_name  = "Doe"
      pit_enabled                = true
    }
  }
  expect_failures = [var.backup_compliance_policy]
}
