output "project" {
  description = "MongoDB Atlas project details"
  value = {
    id                           = mongodbatlas_project.this.id
    org_id                       = mongodbatlas_project.this.org_id
    name                         = mongodbatlas_project.this.name
    created                      = mongodbatlas_project.this.created
    cluster_count                = mongodbatlas_project.this.cluster_count
    project_owner_id             = mongodbatlas_project.this.project_owner_id
    with_default_alerts_settings = mongodbatlas_project.this.with_default_alerts_settings
    region_usage_restrictions    = mongodbatlas_project.this.region_usage_restrictions
    tags                         = mongodbatlas_project.this.tags
  }
}

output "project_settings" {
  description = "All project settings returned by Atlas for the project"
  value = {
    is_schema_advisor_enabled             = mongodbatlas_project.this.is_schema_advisor_enabled
    is_collect_database_specifics_enabled = mongodbatlas_project.this.is_collect_database_specifics_statistics_enabled
    is_data_explorer_enabled              = mongodbatlas_project.this.is_data_explorer_enabled
    is_performance_advisor_enabled        = mongodbatlas_project.this.is_performance_advisor_enabled
    is_realtime_performance_panel_enabled = mongodbatlas_project.this.is_realtime_performance_panel_enabled
    is_extended_storage_sizes_enabled     = mongodbatlas_project.this.is_extended_storage_sizes_enabled
  }
}

output "project_limits" {
  description = "All project limits returned by Atlas for the project. Limit name is the key, value is a map of limit details."
  value = {
    # using data source as the resource only holds "user configured" limits in the state
    for l in data.mongodbatlas_project.this.limits : l.name => {
      limit_value   = l.value
      current_usage = l.current_usage
      default_limit = l.default_limit
      maximum_limit = l.maximum_limit
    }
  }
}

output "ip_access_list" {
  description = "Project IP access list entries."
  value       = local.ip_access_list_enabled ? module.ip_access_list[0].entries : []
}

output "maintenance_window" {
  description = "Maintenance window configuration if set."
  value       = local.maintenance_window_configured && local.maintenance_window_enabled && local.maintenance_window_scheduled ? module.maintenance_window[0].maintenance_window : null
}
