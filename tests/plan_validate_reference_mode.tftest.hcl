mock_provider "mongodbatlas" {
  mock_data "mongodbatlas_project" {
    defaults = {
      id            = "000000000000000000000000"
      name          = "mock-existing-project"
      org_id        = "000000000000000000000001"
      created       = "2026-01-01T00:00:00Z"
      cluster_count = 2
    }
  }
}

run "reference_mode_minimal" {
  command = plan
  variables {
    project_id = "000000000000000000000000"
  }
  assert {
    condition     = length(mongodbatlas_project.this) == 0
    error_message = "Expected no project resource in reference mode"
  }
  assert {
    condition     = length(data.mongodbatlas_project.this) == 1
    error_message = "Expected data source in reference mode"
  }
  assert {
    condition     = output.id == var.project_id
    error_message = "Expected id output to match project_id input"
  }
  assert {
    condition     = output.cluster_count == 2
    error_message = "Expected cluster_count output from data source"
  }
  assert {
    condition     = output.created_at == "2026-01-01T00:00:00Z"
    error_message = "Expected created_at output from data source"
  }
}

run "reference_mode_complete" {
  command = plan
  variables {
    project_id = "000000000000000000000000"
    maintenance_window = {
      enabled     = true
      day_of_week = 7
      hour_of_day = 2
    }
    ip_access_list = [
      { source = "203.0.113.0/24", comment = "Office VPN" },
    ]
    log_integration = {
      otel = [
        {
          log_types = ["MONGOD"]
          endpoint  = "https://otel.example.com:4318"
          headers   = [{ name = "Authorization", value = "Bearer token" }]
        }
      ]
    }
  }
  assert {
    condition     = length(mongodbatlas_project.this) == 0
    error_message = "Expected no project resource in reference mode"
  }
  assert {
    condition     = length(data.mongodbatlas_project.this) == 1
    error_message = "Expected data source in reference mode"
  }
  assert {
    condition     = length(module.maintenance_window) == 1
    error_message = "Expected maintenance_window submodule to be instantiated"
  }
  assert {
    condition     = length(module.ip_access_list) == 1
    error_message = "Expected ip_access_list submodule to be instantiated"
  }
  assert {
    condition     = length(module.log_integration) == 1
    error_message = "Expected log_integration submodule to be instantiated"
  }
}

run "reference_mode_rejects_name" {
  command = plan
  variables {
    project_id = "000000000000000000000000"
    name       = "test-project"
  }
  expect_failures = [var.project_id]
}

run "reference_mode_rejects_limits" {
  command = plan
  variables {
    project_id = "000000000000000000000000"
    limits     = { "atlas.project.deployment.clusters" = 100 }
  }
  expect_failures = [var.project_id]
}

run "reference_mode_rejects_project_settings" {
  command = plan
  variables {
    project_id = "000000000000000000000000"
    project_settings = {
      is_data_explorer_enabled = false
    }
  }
  expect_failures = [var.project_id]
}

run "reference_mode_rejects_project_owner_id" {
  command = plan
  variables {
    project_id       = "000000000000000000000000"
    project_owner_id = "000000000000000000000001"
  }
  expect_failures = [var.project_id]
}

run "reference_mode_rejects_region_usage_restrictions" {
  command = plan
  variables {
    project_id                = "000000000000000000000000"
    region_usage_restrictions = "GOV_REGIONS_ONLY"
  }
  expect_failures = [var.project_id]
}

run "reference_mode_rejects_tags" {
  command = plan
  variables {
    project_id = "000000000000000000000000"
    tags       = { Environment = "production" }
  }
  expect_failures = [var.project_id]
}

run "managed_mode_requires_name" {
  command = plan
  variables {
    org_id = "000000000000000000000000"
  }
  expect_failures = [var.project_id]
}

run "managed_mode_requires_org_id" {
  command = plan
  variables {
    name = "test-project"
  }
  expect_failures = [var.project_id]
}
