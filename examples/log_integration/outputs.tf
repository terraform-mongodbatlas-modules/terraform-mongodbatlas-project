output "id" {
  description = "MongoDB Atlas project ID."
  value       = module.atlas_project.id
}

output "log_integration" {
  description = "Log integration IDs, types, and log types."
  value       = module.atlas_project.log_integration
}
