output "id" {
  description = "The MongoDB Atlas project ID."
  value       = module.atlas_project.id
}

output "cluster_name" {
  description = "The MongoDB Atlas cluster name."
  value       = mongodbatlas_advanced_cluster.this.name
}

output "backup_compliance_policy_items" {
  description = "Effective backup compliance policy items."
  value       = module.atlas_project.backup_compliance_policy_items
}
