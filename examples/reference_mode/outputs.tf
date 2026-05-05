output "id" {
  description = "MongoDB Atlas project ID."
  value       = module.atlas_project.id
}

output "cluster_count" {
  description = "MongoDB Atlas project cluster count."
  value       = module.atlas_project.cluster_count
}

output "maintenance_window" {
  description = "Maintenance window details."
  value       = module.atlas_project.maintenance_window
}

output "log_integration" {
  description = "Log integration IDs, types, and log types."
  value       = module.atlas_project.log_integration
}
