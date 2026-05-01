variable "project_id" {
  type        = string
  description = "The MongoDB Atlas project ID."
}

variable "authorized_email" {
  type        = string
  description = "Email address of the user who is authorized to update the Backup Compliance Policy."
}

variable "authorized_user_first_name" {
  type        = string
  description = "First name of the authorized user."
}

variable "authorized_user_last_name" {
  type        = string
  description = "Last name of the authorized user."
}

variable "copy_protection_enabled" {
  type        = bool
  description = "Enable copy protection. Prevents deleting backup snapshots for all clusters in the project."
  default     = false
}

variable "encryption_at_rest_enabled" {
  type        = bool
  description = "Require encryption at rest for all clusters in the project."
  default     = false
}

variable "pit_enabled" {
  type        = bool
  description = "Enable point-in-time restores for all clusters in the project."
  default     = false
}

variable "restore_window_days" {
  type        = number
  description = "Number of days for point-in-time restore window. Required when pit_enabled is true."
  default     = null
}

variable "policy_items" {
  type = list(object({
    frequency_type     = string
    frequency_interval = number
    retention_unit     = string
    retention_value    = number
  }))
  description = "User-provided policy items. Each frequency_type may appear at most once. Overrides the default for that frequency_type."
  default     = []
  nullable    = false
}

variable "skip_default_policy_items" {
  type        = bool
  description = "When true, disable default policy items. Only user-provided policy_items are applied."
  default     = false
}
