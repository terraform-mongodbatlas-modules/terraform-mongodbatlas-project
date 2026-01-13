resource "mongodbatlas_project" "this" {
  name   = var.name
  org_id = var.org_id

  project_owner_id = var.project_owner_id

  is_collect_database_specifics_statistics_enabled = try(var.project_settings.is_collect_database_specifics_enabled, null)
  is_data_explorer_enabled                         = try(var.project_settings.is_data_explorer_enabled, null)
  is_extended_storage_sizes_enabled                = try(var.project_settings.is_extended_storage_sizes_enabled, null)
  is_performance_advisor_enabled                   = try(var.project_settings.is_performance_advisor_enabled, null)
  is_realtime_performance_panel_enabled            = try(var.project_settings.is_realtime_performance_panel_enabled, null)
  is_schema_advisor_enabled                        = try(var.project_settings.is_schema_advisor_enabled, null)

  with_default_alerts_settings = var.with_default_alerts_settings

  dynamic "limits" {
    for_each = var.limits
    content {
      name  = limits.key
      value = limits.value
    }
  }

  tags = var.tags
}

data "mongodbatlas_project" "this" {
  project_id = mongodbatlas_project.this.id

  depends_on = [mongodbatlas_project.this]
}
