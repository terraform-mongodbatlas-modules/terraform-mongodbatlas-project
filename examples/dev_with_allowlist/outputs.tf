output "id" {
  description = "The MongoDB Atlas project ID."
  value       = module.atlas_project.id
}

output "cluster_count" {
  description = "The MongoDB Atlas project cluster count."
  value       = module.atlas_project.cluster_count
}
