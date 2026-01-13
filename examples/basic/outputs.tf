output "project_id" {
  description = "The unique identifier for the project."
  value       = module.atlas_project.id
}

output "project_name" {
  description = "The name of the project."
  value       = module.atlas_project.name
}
