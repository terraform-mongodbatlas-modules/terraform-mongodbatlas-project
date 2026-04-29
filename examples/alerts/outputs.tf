output "id" {
  description = "The MongoDB Atlas project ID."
  value       = module.atlas_project.id
}

output "alert_configuration_ids" {
  description = "Alert configuration IDs."
  value = {
    no_primary     = mongodbatlas_alert_configuration.no_primary.alert_configuration_id
    disk_partition = mongodbatlas_alert_configuration.disk_partition.alert_configuration_id
  }
}
