resource "mongodbatlas_project" "this" {
  name   = var.name
  org_id = var.org_id

  project_owner_id = var.project_owner_id

  is_collect_database_specifics_statistics_enabled = var.project_settings.is_collect_database_specifics_enabled
  is_data_explorer_enabled                         = var.project_settings.is_data_explorer_enabled
  is_extended_storage_sizes_enabled                = var.project_settings.is_extended_storage_sizes_enabled
  is_performance_advisor_enabled                   = var.project_settings.is_performance_advisor_enabled
  is_realtime_performance_panel_enabled            = var.project_settings.is_realtime_performance_panel_enabled
  is_schema_advisor_enabled                        = var.project_settings.is_schema_advisor_enabled

  with_default_alerts_settings = var.with_default_alerts_settings
  region_usage_restrictions    = var.region_usage_restrictions

  dynamic "limits" {
    for_each = var.limits
    content {
      name  = limits.key
      value = limits.value
    }
  }

  tags = var.tags
}

locals {
  ip_access_list_entries = var.ip_access_list
  ip_access_list_enabled = length(var.ip_access_list) > 0

  maintenance_window_configured = var.maintenance_window != null
  maintenance_window_enabled    = var.maintenance_window == null ? false : coalesce(var.maintenance_window.enabled, true)
  maintenance_window_scheduled  = var.maintenance_window != null
}

module "ip_access_list" {
  source = "./modules/ip_access_list"
  count  = local.ip_access_list_enabled ? 1 : 0

  project_id = mongodbatlas_project.this.id
  entries    = local.ip_access_list_entries
}

module "maintenance_window" {
  source = "./modules/maintenance_window"
  count  = (local.maintenance_window_configured && local.maintenance_window_enabled && local.maintenance_window_scheduled) ? 1 : 0

  project_id              = mongodbatlas_project.this.id
  day_of_week             = var.maintenance_window != null ? var.maintenance_window.day_of_week : null
  hour_of_day             = var.maintenance_window != null ? var.maintenance_window.hour_of_day : null
  defer                   = try(var.maintenance_window.defer, false)
  auto_defer              = try(var.maintenance_window.auto_defer, false)
  auto_defer_once_enabled = try(var.maintenance_window.auto_defer_once_enabled, false)
  protected_hours         = try(var.maintenance_window.protected_hours, null)
}

data "mongodbatlas_project" "this" {
  project_id = mongodbatlas_project.this.id

  depends_on = [
    mongodbatlas_project.this,
    module.ip_access_list, # required because limits such as "atlas.project.security.networkAccess.entries" may change when ip access list changes
  ]
}
