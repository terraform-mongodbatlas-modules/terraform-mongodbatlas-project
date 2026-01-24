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
