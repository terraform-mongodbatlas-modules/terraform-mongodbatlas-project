mock_provider "mongodbatlas" {}

variables {
  name   = "test-project"
  org_id = "000000000000000000000000"
}

run "minimal_project" {
  command = plan
  assert {
    condition     = mongodbatlas_project.this[0].name == var.name
    error_message = "Expected project name to match input"
  }
}

run "ip_access_list_entries" {
  command = plan
  variables {
    ip_access_list = [
      { source = "203.0.113.0/24", comment = "Office VPN" },
      { source = "198.51.100.10" },
      { source = "sg-0123456789abcdef0" },
      { source = "2001:0db8:0000:0000:0000:0000:0000:0001" }
    ]
  }
  assert {
    condition     = length(module.ip_access_list) == 1
    error_message = "Expected ip_access_list submodule to be instantiated"
  }
  assert {
    condition     = length(module.ip_access_list[0].entries) == 4
    error_message = "Expected four IP access list resources"
  }
}

run "maintenance_window_configured" {
  command = plan
  variables {
    maintenance_window = {
      enabled     = true
      day_of_week = 7
      hour_of_day = 3
      auto_defer  = false
    }
  }
  assert {
    condition     = length(module.maintenance_window) == 1
    error_message = "Expected maintenance_window submodule to be instantiated"
  }
}

run "maintenance_window_disabled_default" {
  command = plan
  variables {
    maintenance_window = {
      enabled = false
    }
  }
  assert {
    condition     = length(module.maintenance_window) == 0
    error_message = "Expected maintenance_window submodule to be disabled when enabled is false"
  }
}

run "default_feature_set_invalid_value" {
  command = plan
  variables {
    default_feature_set = "INVALID"
  }
  expect_failures = [var.default_feature_set]
}

run "default_feature_set_standard" {
  command = plan
  variables {
    default_feature_set = "STANDARD"
  }
  # default_feature_set is unused in v1, we only verify that the project is created.
  assert {
    condition     = length(mongodbatlas_project.this) == 1
    error_message = "Expected project to be created"
  }
}

run "default_feature_set_recommended" {
  command = plan
  variables {
    default_feature_set = "RECOMMENDED"
  }
  # default_feature_set is unused in v1, we only verify that the project is created.
  assert {
    condition     = length(mongodbatlas_project.this) == 1
    error_message = "Expected project to be created"
  }
}

run "maintenance_window_enabled_requires_day_and_hour" {
  command = plan
  variables {
    maintenance_window = {
      enabled     = true
      day_of_week = null
      hour_of_day = null
    }
  }
  expect_failures = [var.maintenance_window]
}
