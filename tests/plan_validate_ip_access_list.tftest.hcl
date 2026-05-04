mock_provider "mongodbatlas" {}

variables {
  name   = "test-project"
  org_id = "000000000000000000000000"
}

run "ip_access_list_duplicate_entries" {
  command = plan

  module {
    source = "./modules/ip_access_list"
  }

  variables {
    project_id = "000000000000000000000000"
    entries = [
      { source = "203.0.113.0" },
      { source = "203.0.113.0/32" }
    ]
  }
  expect_failures = [
    mongodbatlas_project_ip_access_list.this
  ]
}

run "ip_access_list_allow_all_ipv4_blocked" {
  command = plan

  variables {
    ip_access_list = [
      { source = "0.0.0.0/0", comment = "allow all" }
    ]
  }
  expect_failures = [
    var.ip_access_list
  ]
}

run "ip_access_list_allow_all_ipv6_blocked" {
  command = plan

  variables {
    ip_access_list = [
      { source = "::/0", comment = "allow all" }
    ]
  }
  expect_failures = [
    var.ip_access_list
  ]
}

run "ip_access_list_allow_all_skipped" {
  command = plan

  variables {
    ip_access_list = [
      { source = "0.0.0.0/0", comment = "allow all IPv4", skip_allow_all_validation = true },
      { source = "::/0", comment = "allow all IPv6", skip_allow_all_validation = true }
    ]
  }
  assert {
    condition     = length(module.ip_access_list) == 1
    error_message = "Expected ip_access_list submodule to be instantiated"
  }
}
