module "atlas_project" {
  source = "../.."

  name   = var.project_name
  org_id = var.org_id

  default_feature_set = "STANDARD"

  project_settings = {
    is_schema_advisor_enabled             = false
    is_collect_database_specifics_enabled = false
    is_data_explorer_enabled              = false
    is_performance_advisor_enabled        = false
    is_realtime_performance_panel_enabled = false
    is_extended_storage_sizes_enabled     = false
  }
}
