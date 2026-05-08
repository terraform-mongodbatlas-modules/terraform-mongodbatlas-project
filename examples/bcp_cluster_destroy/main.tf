module "atlas_project" {
  source = "../.."

  name   = var.project_name
  org_id = var.org_id

  backup_compliance_policy = {
    authorized_email           = var.bcp_authorized_email
    authorized_user_first_name = var.bcp_authorized_user_first_name
    authorized_user_last_name  = var.bcp_authorized_user_last_name

    skip_default_policy_items = true

    policy_items = [
      { frequency_type = "hourly", frequency_interval = 6, retention_unit = "days", retention_value = 7 }
    ]
  }
}

# To destroy the cluster and backup schedule, remove or comment out the resources below and run `terraform apply`.

resource "mongodbatlas_advanced_cluster" "this" {
  project_id     = module.atlas_project.id
  name           = var.cluster_name
  cluster_type   = "REPLICASET"
  backup_enabled = true

  replication_specs = [{
    region_configs = [{
      priority      = 7
      provider_name = "AWS"
      region_name   = "US_EAST_1"
      electable_specs = {
        instance_size = "M10"
        node_count    = 3
      }
    }]
  }]
}

resource "mongodbatlas_cloud_backup_schedule" "this" {
  project_id   = mongodbatlas_advanced_cluster.this.project_id
  cluster_name = mongodbatlas_advanced_cluster.this.name

  policy_item_hourly {
    frequency_interval = 6
    retention_unit     = "days"
    retention_value    = 14
  }

  # Allows the resource destruction to succeed when a Backup Compliance Policy is active.
  # The schedule is retained in Atlas and removed when the cluster is deleted.
  # Without this flag, `terraform destroy` would fail.
  skip_destroy = true
}
