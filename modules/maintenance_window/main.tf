resource "mongodbatlas_maintenance_window" "this" {
  project_id              = var.project_id
  day_of_week             = var.day_of_week
  hour_of_day             = var.hour_of_day
  defer                   = var.defer
  auto_defer              = var.auto_defer
  auto_defer_once_enabled = var.auto_defer_once_enabled

  dynamic "protected_hours" {
    for_each = var.protected_hours == null ? [] : [var.protected_hours]
    content {
      start_hour_of_day = protected_hours.value.start_hour_of_day
      end_hour_of_day   = protected_hours.value.end_hour_of_day
    }
  }
}
