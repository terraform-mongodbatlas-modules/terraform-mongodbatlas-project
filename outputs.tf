output "id" {
  description = "MongoDB Atlas project ID."
  value       = local.project_id
}

output "created_at" {
  description = "MongoDB Atlas project creation time (RFC3339)."
  value       = local.project_created_at
}

output "cluster_count" {
  description = "MongoDB Atlas project cluster count."
  value       = local.project_cluster_count
}

output "maintenance_window" {
  description = "Maintenance window details."
  value       = length(module.maintenance_window) > 0 ? module.maintenance_window[0].maintenance_window : null
}

output "log_integration" {
  description = "Log integration IDs, types, and log types."
  value       = length(module.log_integration) > 0 ? module.log_integration[0].log_integration : []
}
