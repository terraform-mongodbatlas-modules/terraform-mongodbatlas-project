module "atlas_project" {
  source = "../.."

  name   = var.project_name
  org_id = var.org_id

  project_settings = {
    is_data_explorer_enabled          = false
    is_performance_advisor_enabled    = true
    is_extended_storage_sizes_enabled = true
  }

  limits = {
    "atlas.project.deployment.clusters"                 = 100
    "atlas.project.security.databaseAccess.customRoles" = 50
  }

  ip_access_list = [
    { source = "203.0.113.0/24", comment = "Office VPN" },
    { source = "198.51.100.10", comment = "Admin workstation" }
  ]

  maintenance_window = {
    enabled     = true
    day_of_week = 6
    hour_of_day = 2
    auto_defer  = false

    protected_hours = {
      start_hour_of_day = 18
      end_hour_of_day   = 23
    }
  }

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Tier        = "baseline"
  }
}
