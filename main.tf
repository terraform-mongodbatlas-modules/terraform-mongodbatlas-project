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
}

module "ip_access_list" {
  source = "./modules/ip_access_list"
  count  = local.ip_access_list_enabled ? 1 : 0

  project_id = mongodbatlas_project.this.id
  entries    = local.ip_access_list_entries
}

data "mongodbatlas_project" "this" {
  project_id = mongodbatlas_project.this.id

  depends_on = [
    mongodbatlas_project.this,
    module.ip_access_list # required because limits such as "atlas.project.security.networkAccess.entries" may change when ip access list changes
  ]
}
