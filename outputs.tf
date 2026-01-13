output "id" {
  description = "The unique identifier for the project."
  value       = mongodbatlas_project.this.id
}

output "name" {
  description = "The name of the project."
  value       = mongodbatlas_project.this.name
}
