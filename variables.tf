variable "name" {
  type        = string
  description = "The name of the MongoDB Atlas project."
  nullable    = false
}

variable "org_id" {
  type        = string
  description = "The ID of the MongoDB Atlas organization in which to create the project."
  nullable    = false
}

variable "project_owner_id" {
  type        = string
  description = "Unique 24-hexadecimal digit string that identifies the Atlas user account to be granted the Project Owner role on the specified project."
  default     = null
}

variable "project_settings" {
  description = "Optional Atlas project feature settings. Unset values do not override Atlas defaults."
  type = object({
    is_schema_advisor_enabled             = optional(bool)
    is_collect_database_specifics_enabled = optional(bool)
    is_data_explorer_enabled              = optional(bool)
    is_performance_advisor_enabled        = optional(bool)
    is_realtime_performance_panel_enabled = optional(bool)
    is_extended_storage_sizes_enabled     = optional(bool)
  })
  default = {}
}

variable "limits" {
  description = <<-EOT
  Optional Atlas project limits keyed by limit name. Limit name is the key, value is the limit value. 
  For example, 
  limits = {
    "atlas.project.deployment.clusters" = 100
    }
  EOT

  type    = map(number)
  default = {}
}

variable "ip_access_list" {
  description = <<-EOT
  IP access list entries for the Atlas project. Each "source" maps to one of: cidrBlock, ipAddress, or
  awsSecurityGroup.
  
  Note: When using AWS security group IDs, the value must be known at plan time. If the ID is created in the same apply, Terraform will fail.

  Example:
  ip_access_list = [
    { source = "203.0.113.0/24", comment = "Office VPN" },
    { source = "198.51.100.10" },
    { source = "sg-0123456789abcdef0" }
  ]
  EOT
  type = list(object({
    source  = string
    comment = optional(string)
  }))
  default = []

  validation {
    condition = alltrue([
      for entry in var.ip_access_list : (
        can(cidrhost(entry.source, 0)) ||
        can(regex("^sg-[0-9a-fA-F]+$", entry.source)) ||
        can(cidrhost("${entry.source}/32", 0)) ||
        can(cidrhost("${entry.source}/128", 0))
      )
    ])
    error_message = "ip_access_list.source values must be valid CIDR blocks, IP addresses, or AWS security group IDs (sg-...)."
  }
}

variable "maintenance_window" {
  description = <<-EOT
  Maintenance window configuration for the Atlas project.
  - Typically, you don't need to manually configure a maintenance window; Atlas performs maintenance automatically in a rolling manner to preserve continuous availability for resilient applications.
  https://www.mongodb.com/docs/atlas/tutorial/cluster-maintenance-window/
  - To temporarily defer maintenance, use the Atlas CLI/API. See `atlas maintenanceWindows defer` documentation.
  https://www.mongodb.com/docs/atlas/cli/current/command/atlas-maintenanceWindows-defer/#atlas-maintenancewindows-defer
  EOT
  type = object({
    enabled                 = bool
    day_of_week             = optional(number)
    hour_of_day             = optional(number)
    auto_defer              = optional(bool, false)
    auto_defer_once_enabled = optional(bool, false)
    protected_hours = optional(object({
      start_hour_of_day = number
      end_hour_of_day   = number
    }))
  })
  default  = { enabled = false }
  nullable = false

  validation {
    condition = (
      !var.maintenance_window.enabled ||
      (var.maintenance_window.day_of_week != null && var.maintenance_window.hour_of_day != null)
    )
    error_message = "When maintenance_window.enabled is true, day_of_week and hour_of_day must both be set."
  }
}

variable "with_default_alerts_settings" {
  type        = bool
  description = "Flag that indicates whether to create the project with default alert settings."
  default     = true
}

variable "region_usage_restrictions" {
  type        = string
  description = "Set to `GOV_REGIONS_ONLY` to restrict project to government regions. Defaults to standard regions. Cannot mix government and standard regions in the same project. See [MongoDB Atlas for Government](https://www.mongodb.com/docs/atlas/government/api/#creating-a-project)."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to assign to the project."
  default     = {}
}
