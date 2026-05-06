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
