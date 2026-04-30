locals {
  defaults = {
    hourly  = { frequency_interval = 6, retention_unit = "days", retention_value = 7 }
    daily   = { frequency_interval = 1, retention_unit = "days", retention_value = 7 }
    weekly  = { frequency_interval = 6, retention_unit = "weeks", retention_value = 4 }
    monthly = { frequency_interval = 40, retention_unit = "months", retention_value = 12 }
    yearly  = { frequency_interval = 12, retention_unit = "years", retention_value = 1 }
  }

  user_items = var.policy_items

  user_items_by_type = { for i in local.user_items : i.frequency_type => i }

  ondemand = lookup(local.user_items_by_type, "ondemand", null)
  hourly   = var.skip_default_policy_items ? lookup(local.user_items_by_type, "hourly", null) : coalesce(lookup(local.user_items_by_type, "hourly", null), local.defaults.hourly)
  daily    = var.skip_default_policy_items ? lookup(local.user_items_by_type, "daily", null) : coalesce(lookup(local.user_items_by_type, "daily", null), local.defaults.daily)
  weekly   = var.skip_default_policy_items ? lookup(local.user_items_by_type, "weekly", null) : coalesce(lookup(local.user_items_by_type, "weekly", null), local.defaults.weekly)
  monthly  = var.skip_default_policy_items ? lookup(local.user_items_by_type, "monthly", null) : coalesce(lookup(local.user_items_by_type, "monthly", null), local.defaults.monthly)
  yearly   = var.skip_default_policy_items ? lookup(local.user_items_by_type, "yearly", null) : coalesce(lookup(local.user_items_by_type, "yearly", null), local.defaults.yearly)
}

resource "mongodbatlas_backup_compliance_policy" "this" {
  project_id = var.project_id

  authorized_email           = var.authorized_email
  authorized_user_first_name = var.authorized_user_first_name
  authorized_user_last_name  = var.authorized_user_last_name

  copy_protection_enabled    = var.copy_protection_enabled
  encryption_at_rest_enabled = var.encryption_at_rest_enabled
  pit_enabled                = var.pit_enabled
  restore_window_days        = var.restore_window_days

  dynamic "on_demand_policy_item" {
    for_each = local.ondemand != null ? [local.ondemand] : []
    content {
      frequency_interval = on_demand_policy_item.value.frequency_interval
      retention_unit     = on_demand_policy_item.value.retention_unit
      retention_value    = on_demand_policy_item.value.retention_value
    }
  }

  dynamic "policy_item_hourly" {
    for_each = local.hourly != null ? [local.hourly] : []
    content {
      frequency_interval = policy_item_hourly.value.frequency_interval
      retention_unit     = policy_item_hourly.value.retention_unit
      retention_value    = policy_item_hourly.value.retention_value
    }
  }

  dynamic "policy_item_daily" {
    for_each = local.daily != null ? [local.daily] : []
    content {
      frequency_interval = policy_item_daily.value.frequency_interval
      retention_unit     = policy_item_daily.value.retention_unit
      retention_value    = policy_item_daily.value.retention_value
    }
  }

  dynamic "policy_item_weekly" {
    for_each = local.weekly != null ? [local.weekly] : []
    content {
      frequency_interval = policy_item_weekly.value.frequency_interval
      retention_unit     = policy_item_weekly.value.retention_unit
      retention_value    = policy_item_weekly.value.retention_value
    }
  }

  dynamic "policy_item_monthly" {
    for_each = local.monthly != null ? [local.monthly] : []
    content {
      frequency_interval = policy_item_monthly.value.frequency_interval
      retention_unit     = policy_item_monthly.value.retention_unit
      retention_value    = policy_item_monthly.value.retention_value
    }
  }

  dynamic "policy_item_yearly" {
    for_each = local.yearly != null ? [local.yearly] : []
    content {
      frequency_interval = policy_item_yearly.value.frequency_interval
      retention_unit     = policy_item_yearly.value.retention_unit
      retention_value    = policy_item_yearly.value.retention_value
    }
  }
}
