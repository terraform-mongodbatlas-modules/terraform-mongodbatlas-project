output "maintenance_window" {
  description = "Maintenance window configuration."
  value = {
    project_id              = mongodbatlas_maintenance_window.this.project_id
    day_of_week             = mongodbatlas_maintenance_window.this.day_of_week
    hour_of_day             = mongodbatlas_maintenance_window.this.hour_of_day
    defer                   = mongodbatlas_maintenance_window.this.defer
    auto_defer              = mongodbatlas_maintenance_window.this.auto_defer
    auto_defer_once_enabled = mongodbatlas_maintenance_window.this.auto_defer_once_enabled
    number_of_deferrals     = mongodbatlas_maintenance_window.this.number_of_deferrals
    start_asap              = mongodbatlas_maintenance_window.this.start_asap
    time_zone_id            = mongodbatlas_maintenance_window.this.time_zone_id
    protected_hours         = mongodbatlas_maintenance_window.this.protected_hours
  }
}
