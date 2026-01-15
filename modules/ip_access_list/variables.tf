variable "project_id" {
  type        = string
  description = "The MongoDB Atlas project ID."
}

variable "entries" {
  type = list(object({
    entry   = string
    comment = optional(string)
  }))
  description = "IP access list entries to create."
  default     = []

  validation {
    condition = alltrue([
      for entry in var.entries : (
        can(cidrhost(entry.entry, 0)) ||
        can(regex("^sg-[0-9a-fA-F]+$", entry.entry)) ||
        can(cidrhost("${entry.entry}/32", 0)) ||
        can(cidrhost("${entry.entry}/128", 0))
      )
    ])
    error_message = "Each entry must be a valid CIDR block, IP address, or AWS security group ID (sg-...)."
  }
}
