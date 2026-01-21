output "maintenance_window" {
  description = "Maintenance window details."
  value = {
    number_of_deferrals = mongodbatlas_maintenance_window.this.number_of_deferrals
    start_asap          = mongodbatlas_maintenance_window.this.start_asap
    time_zone_id        = mongodbatlas_maintenance_window.this.time_zone_id
  }
}
