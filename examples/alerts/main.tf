module "atlas_project" {
  source = "../.."

  name   = var.project_name
  org_id = var.org_id
}

resource "mongodbatlas_alert_configuration" "no_primary" {
  project_id = module.atlas_project.id
  event_type = "NO_PRIMARY"
  enabled    = true

  notification {
    type_name     = "GROUP"
    interval_min  = 5
    delay_min     = 0
    email_enabled = true
    roles         = ["GROUP_OWNER"]
  }
}

resource "mongodbatlas_alert_configuration" "disk_partition" {
  project_id = module.atlas_project.id
  event_type = "OUTSIDE_METRIC_THRESHOLD"
  enabled    = true

  metric_threshold_config {
    metric_name = "DISK_PARTITION_SPACE_PERCENT_USED"
    operator    = "GREATER_THAN"
    threshold   = 90
    units       = "RAW"
  }

  notification {
    type_name     = "GROUP"
    interval_min  = 60
    delay_min     = 0
    email_enabled = true
    roles         = ["GROUP_OWNER"]
  }
}
