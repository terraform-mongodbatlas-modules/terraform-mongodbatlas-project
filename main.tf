resource "mongodbatlas_project" "this" {
  is_collect_database_specifics_statistics_enabled = var.is_collect_database_specifics_statistics_enabled
  is_data_explorer_enabled                         = var.is_data_explorer_enabled
  is_extended_storage_sizes_enabled                = var.is_extended_storage_sizes_enabled
  is_performance_advisor_enabled                   = var.is_performance_advisor_enabled
  is_realtime_performance_panel_enabled            = var.is_realtime_performance_panel_enabled
  is_schema_advisor_enabled                        = var.is_schema_advisor_enabled
  dynamic "limits" {
    for_each = var.limits == null ? [] : var.limits
    content {
      name  = limits.value.name
      value = limits.value.value
    }
  }
  name                      = var.name
  org_id                    = var.org_id
  project_owner_id          = var.project_owner_id
  region_usage_restrictions = var.region_usage_restrictions
  tags                      = var.tags
  dynamic "teams" {
    for_each = var.teams == null ? [] : var.teams
    content {
      role_names = teams.value.role_names
      team_id    = teams.value.team_id
    }
  }
  with_default_alerts_settings = var.with_default_alerts_settings
}

module "ip_access_entry" {
  source   = "./modules/ip_access_entry"
  for_each = var.dev_ips

  ip_access_entry = {
    comment    = each.value.comment
    ip_address = each.value.ip_address
    project_id = mongodbatlas_project.this.id
  }
}

module "cidr_access_entry" {
  source   = "./modules/cidr_access_entry"
  for_each = var.access_cidrs

  comment    = each.value.comment
  cidr_block = each.value.cidr_block
  project_id = mongodbatlas_project.this.id
}

resource "mongodbatlas_auditing" "this" {
  count = var.auditing_enabled ? 1 : 0

  audit_authorization_success = var.auditing.audit_authorization_success
  audit_filter                = var.auditing.audit_filter
  enabled                     = true
  project_id                  = mongodbatlas_project.this.id
}
