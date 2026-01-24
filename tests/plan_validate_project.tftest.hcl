mock_provider "mongodbatlas" {}

variables {
  name   = "test-project"
  org_id = "000000000000000000000000"
}

run "minimal_project" {
  command = plan
  assert {
    condition     = mongodbatlas_project.this.name == var.name
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
