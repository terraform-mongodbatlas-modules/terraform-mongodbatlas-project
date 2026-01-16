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

variable "defer" {
  type        = bool
  description = "Whether to defer maintenance to the next window."
  default     = false
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
