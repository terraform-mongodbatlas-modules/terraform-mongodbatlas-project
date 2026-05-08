output "id" {
  description = "The MongoDB Atlas project ID."
  value       = module.atlas_project.id
}

output "backup_compliance_policy_items" {
  description = "Effective backup compliance policy items."
  value       = module.atlas_project.backup_compliance_policy_items
}
