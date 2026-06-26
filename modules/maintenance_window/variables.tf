variable "project_id" {
  type        = string
  description = "The MongoDB Atlas project ID."
}

variable "day_of_week" {
  type        = number
  description = "Day of week for maintenance window (1-7, where 1 is Monday)."
}

variable "hour_of_day" {
  type        = number
  description = "Hour of day in UTC for maintenance window (0-23)."
}

variable "auto_defer" {
  type        = bool
  description = "Whether Atlas can automatically defer maintenance beyond the scheduled window."
  default     = false
}

variable "auto_defer_once_enabled" {
  type        = bool
  description = "Whether Atlas can automatically defer maintenance once."
  default     = false
}

variable "wave_assignment" {
  type        = number
  description = "Maintenance wave assignment for the project (1, 2, or 3). Configurable only when the organization's wave assignment mode is MANUAL. Omit to use the organization default."
  default     = null
}

variable "protected_hours" {
  description = "Protected hours configuration for the maintenance window."
  type = object({
    start_hour_of_day = number
    end_hour_of_day   = number
  })
  default = null

  validation {
    condition = var.protected_hours == null || (
      var.protected_hours.start_hour_of_day >= 0 &&
      var.protected_hours.start_hour_of_day <= 23 &&
      var.protected_hours.end_hour_of_day >= 0 &&
      var.protected_hours.end_hour_of_day <= 23
    )
    error_message = "protected_hours start_hour_of_day and end_hour_of_day must be between 0 and 23."
  }
}
