variable "name" {
  type        = string
  description = "The name of the MongoDB Atlas project."
}

variable "org_id" {
  type        = string
  description = "The ID of the MongoDB Atlas organization in which to create the project."
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
  description = "Optional Atlas project limits keyed by limit name."
  type        = map(number)
  default     = {}
}

variable "with_default_alerts_settings" {
  type        = bool
  description = "Flag that indicates whether to create the project with default alert settings."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to assign to the project."
  default     = {}
}
