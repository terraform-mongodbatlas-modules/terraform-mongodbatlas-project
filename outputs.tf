output "id" {
  description = "MongoDB Atlas project ID."
  value       = mongodbatlas_project.this.id
}

output "created_at" {
  description = "MongoDB Atlas project creation time (RFC3339)."
  value       = mongodbatlas_project.this.created
}

output "cluster_count" {
  description = "MongoDB Atlas project cluster count."
  value       = mongodbatlas_project.this.cluster_count
}

output "maintenance_window" {
  description = "Maintenance window configuration if set."
  value       = local.maintenance_window_configured && local.maintenance_window_enabled && local.maintenance_window_scheduled ? module.maintenance_window[0].maintenance_window : null
}
