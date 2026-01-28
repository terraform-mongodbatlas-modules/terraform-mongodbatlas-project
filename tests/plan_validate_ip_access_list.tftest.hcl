mock_provider "mongodbatlas" {}

variables {
  project_id = "000000000000000000000000"
}

run "ip_access_list_duplicate_entries" {
  command = plan

  module {
    source = "./modules/ip_access_list"
  }

  variables {
    entries = [
      { source = "203.0.113.0" },
      { source = "203.0.113.0/32" }
    ]
  }
  expect_failures = [
    mongodbatlas_project_ip_access_list.this
  ]
}
