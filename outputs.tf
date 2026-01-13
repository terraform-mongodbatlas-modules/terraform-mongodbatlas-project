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
    tags                         = mongodbatlas_project.this.tags
  }
}

output "id" {
  description = "The unique identifier for the project."
  value       = mongodbatlas_project.this.id
}

output "name" {
  description = "The name of the project."
  value       = mongodbatlas_project.this.name
}

output "org_id" {
  description = "The ID of the organization that the project belongs to."
  value       = mongodbatlas_project.this.org_id
}

output "created" {
  description = "The timestamp when the project was created."
  value       = mongodbatlas_project.this.created
}

output "cluster_count" {
  description = "The number of clusters in the project."
  value       = mongodbatlas_project.this.cluster_count
}

output "project_settings" {
  description = "Effective project settings read from Atlas after apply (server-side truth)."
  value = {
    is_schema_advisor_enabled             = data.mongodbatlas_project.this.is_schema_advisor_enabled
    is_collect_database_specifics_enabled = data.mongodbatlas_project.this.is_collect_database_specifics_statistics_enabled
    is_data_explorer_enabled              = data.mongodbatlas_project.this.is_data_explorer_enabled
    is_performance_advisor_enabled        = data.mongodbatlas_project.this.is_performance_advisor_enabled
    is_realtime_performance_panel_enabled = data.mongodbatlas_project.this.is_realtime_performance_panel_enabled
    is_extended_storage_sizes_enabled     = data.mongodbatlas_project.this.is_extended_storage_sizes_enabled
  }
}

output "project_limits" {
  description = "All project limits returned by Atlas for the project."
  value = {
    for l in data.mongodbatlas_project.this.limits : l.name => {
      effective_limit = try(l.value, null)
      current_usage   = try(l.current_usage, null)
      default_limit   = try(l.default_limit, null)
      maximum_limit   = try(l.maximum_limit, null)
    }
  }
}
