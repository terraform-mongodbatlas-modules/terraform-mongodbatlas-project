output "policy_items" {
  description = "Effective backup compliance policy items."
  value = concat(
    mongodbatlas_backup_compliance_policy.this.on_demand_policy_item,
    mongodbatlas_backup_compliance_policy.this.policy_item_hourly,
    mongodbatlas_backup_compliance_policy.this.policy_item_daily,
    mongodbatlas_backup_compliance_policy.this.policy_item_weekly,
    mongodbatlas_backup_compliance_policy.this.policy_item_monthly,
    mongodbatlas_backup_compliance_policy.this.policy_item_yearly,
  )
}
