module "atlas_project" {
  source = "../.."

  name   = var.project_name
  org_id = var.org_id

  project_settings = {
    is_schema_advisor_enabled             = true
    is_collect_database_specifics_enabled = true
    is_data_explorer_enabled              = true
    is_performance_advisor_enabled        = true
    is_realtime_performance_panel_enabled = true
    is_extended_storage_sizes_enabled     = true
  }

  limits = {
    "atlas.project.deployment.clusters"                 = 50
    "atlas.project.security.databaseAccess.customRoles" = 25
  }

  maintenance_window = {
    enabled     = true
    day_of_week = 7
    hour_of_day = 2
  }

  ip_access_list = [
    { source = "203.0.113.0/24", comment = "Office VPN" },
    { source = "198.51.100.10", comment = "Admin workstation" },
  ]

  tags = {
    Environment = "production"
    ManagedBy   = "platform"
  }

  backup_compliance_policy = {
    authorized_email           = var.bcp_authorized_email
    authorized_user_first_name = var.bcp_authorized_user_first_name
    authorized_user_last_name  = var.bcp_authorized_user_last_name

    copy_protection_enabled = true
    pit_enabled             = true
    restore_window_days     = 7
  }

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
