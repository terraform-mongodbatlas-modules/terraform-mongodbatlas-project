module "atlas_project" {
  source = "../.."

  project_id = var.project_id

  maintenance_window = {
    enabled     = true
    day_of_week = 7
    hour_of_day = 2
  }

  ip_access_list = [
    { source = "203.0.113.0/24", comment = "Office VPN" },
    { source = "198.51.100.10", comment = "Admin workstation" },
  ]

  log_integration = {
    otel = [
      {
        log_types = ["MONGOD"]
        endpoint  = var.otel_endpoint
        headers   = [{ name = "Authorization", value = var.otel_auth_header }]
      },
    ]
  }
}
