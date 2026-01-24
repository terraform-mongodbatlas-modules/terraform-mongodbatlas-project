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

variable "with_default_alerts_settings" {
  type        = bool
  description = "Flag that indicates whether to create the project with default alert settings."
  default     = true
}

variable "region_usage_restrictions" {
  type        = string
  description = "Optional - set value to GOV_REGIONS_ONLY, Designates that this project can be used for government regions only.  If not set the project will default to standard regions.   You cannot deploy clusters across government and standard regions in the same project. AWS is the only cloud provider for AtlasGov.  For more information see [MongoDB Atlas for Government](https://www.mongodb.com/docs/atlas/government/api/#creating-a-project)."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to assign to the project."
  default     = {}
}
