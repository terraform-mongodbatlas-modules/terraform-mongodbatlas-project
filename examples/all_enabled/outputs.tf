output "id" {
  description = "MongoDB Atlas project ID."
  value       = module.atlas_project.id
}

output "created_at" {
  description = "MongoDB Atlas project creation time (RFC3339)."
  value       = module.atlas_project.created_at
}

output "cluster_count" {
  description = "MongoDB Atlas project cluster count."
  value       = module.atlas_project.cluster_count
}

output "maintenance_window" {
  description = "Maintenance window details."
  value       = module.atlas_project.maintenance_window
}

output "backup_compliance_policy_items" {
  description = "Effective backup compliance policy items."
  value       = module.atlas_project.backup_compliance_policy_items
}

output "log_integration" {
  description = "Log integration IDs, types, and log types."
  value       = module.atlas_project.log_integration
}
