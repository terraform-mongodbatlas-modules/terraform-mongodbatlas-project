variable "project_id" {
  type        = string
  description = "ID of an existing Atlas project. When set, the module operates in reference mode: the project resource is not created and only standalone resources are managed."
  default     = null

  validation {
    condition     = var.project_id != null || var.name != null
    error_message = "name is required when project_id is not set."
  }

  validation {
    condition     = var.project_id != null || var.org_id != null
    error_message = "org_id is required when project_id is not set."
  }

  validation {
    condition     = !(var.project_id != null && var.name != null)
    error_message = "name cannot be set when project_id is set (reference mode)."
  }

  validation {
    condition     = !(var.project_id != null && var.org_id != null)
    error_message = "org_id cannot be set when project_id is set (reference mode)."
  }

  validation {
    condition     = var.project_id == null || length(var.limits) == 0
    error_message = "limits cannot be set when project_id is set (reference mode)."
  }

  validation {
    condition     = var.project_id == null || length([for k, v in var.project_settings : k if v != null]) == 0
    error_message = "project_settings cannot be set when project_id is set (reference mode)."
  }

  validation {
    condition     = var.project_id == null || var.project_owner_id == null
    error_message = "project_owner_id cannot be set when project_id is set (reference mode)."
  }

  validation {
    condition     = var.project_id == null || var.region_usage_restrictions == null
    error_message = "region_usage_restrictions cannot be set when project_id is set (reference mode)."
  }

  validation {
    condition     = var.project_id == null || var.tags == null
    error_message = "tags cannot be set when project_id is set (reference mode)."
  }
}

variable "name" {
  type        = string
  description = "Name of the MongoDB Atlas project. Required when project_id is not set."
  default     = null
}

variable "org_id" {
  type        = string
  description = "ID of the MongoDB Atlas organization. Required when project_id is not set."
  default     = null
}

variable "project_owner_id" {
  type        = string
  description = "Unique 24-hexadecimal digit string that identifies the Atlas user account with the Project Owner role on the specified project."
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
  
  ```hcl
  limits = {
    "atlas.project.deployment.clusters" = 100
  }
  ```
  
  EOT

  type    = map(number)
  default = {}
}

variable "ip_access_list" {
  description = <<-EOT
  IP access list of entries for the Atlas project. Each "source" maps to one of the following: `cidrBlock`, `ipAddress`, or `awsSecurityGroup`.
  
  Note: When using AWS security group IDs, the value must be known at plan time. If you create the ID in the same `apply` command, Terraform fails.

  For example,
  
  ```hcl
  ip_access_list = [
    { source = "203.0.113.0/24", comment = "Office VPN" },
    { source = "198.51.100.10" },
    { source = "sg-0123456789abcdef0" }
  ]
  ```
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
  - Typically, you don't need to manually configure a maintenance window. Atlas performs maintenance automatically in a rolling manner to preserve continuous availability for resilient applications. See [Cluster Maintenance Window](https://www.mongodb.com/docs/atlas/tutorial/cluster-maintenance-window/) in the MongoDB Atlas documentation for more information.
  - To temporarily defer maintenance, use the Atlas CLI/API. See [Atlas `maintenanceWindows` defer](https://www.mongodb.com/docs/atlas/cli/current/command/atlas-maintenanceWindows-defer/#atlas-maintenancewindows-defer) in the MongoDB Atlas documentation for more information.
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

# tflint-ignore: terraform_unused_declarations # Unused for v1.
variable "default_feature_set" {
  description = <<-EOT
    Controls which module features with default values are automatically enabled.

    - **`RECOMMENDED`** (default): features that have module defaults and do not require additional
      customer input are automatically enabled. Upgrading the module version adopts new best
      practices without any configuration changes. Minor version upgrades may introduce plan changes (new resources).
    - **`STANDARD`**: features with module defaults are not automatically enabled. Only Atlas
      defaults apply. Minor version upgrades do not introduce plan changes.
  EOT
  type        = string
  default     = "RECOMMENDED"

  validation {
    condition     = contains(["RECOMMENDED", "STANDARD"], var.default_feature_set)
    error_message = "Invalid value for default_feature_set. Valid values are: RECOMMENDED, STANDARD."
  }
}

variable "with_default_alerts_settings" {
  type        = bool
  description = "Flag that indicates whether to create the project with default alert settings."
  default     = false
}

variable "region_usage_restrictions" {
  type        = string
  description = "Set to `GOV_REGIONS_ONLY` to restrict project to government regions. Defaults to standard regions. Cannot mix government and standard regions in the same project. See [MongoDB Atlas for Government](https://www.mongodb.com/docs/atlas/government/api/#creating-a-project)."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to assign to the project."
  default     = null
}

variable "log_integration" {
  description = <<-EOT
    Log integration configuration for exporting Atlas logs to Datadog, Splunk, and/or OTel collectors.
    For CSP integrations (AWS, Azure & GCP), use their respective MongoDB Atlas modules.

    Each list entry creates one `mongodbatlas_log_integration` resource of the corresponding list type.
    `log_types` is always required - valid values: MONGOD, MONGOS, MONGOD_AUDIT, MONGOS_AUDIT.

    Type-specific fields:
    - `datadog`: `api_key` (sensitive) and `region` (US1, US3, US5, EU, AP1, AP2, US1_FED).
    - `splunk`: `hec_token` (sensitive) and `hec_url`.
    - `otel`: `endpoint` and `headers` (sensitive, max 10 headers and 2 KB).
  EOT
  type = object({
    datadog = optional(list(object({
      log_types = set(string)
      api_key   = string
      region    = string
    })))
    splunk = optional(list(object({
      log_types = set(string)
      hec_token = string
      hec_url   = string
    })))
    otel = optional(list(object({
      log_types = set(string)
      endpoint  = string
      headers   = list(object({ name = string, value = string }))
    })))
  })
  default = null
}
