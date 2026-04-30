variable "project_id" {
  type        = string
  description = "The MongoDB Atlas project ID."
}

variable "entries" {
  type = list(object({
    source                    = string
    comment                   = optional(string)
    skip_allow_all_validation = optional(bool, false)
  }))
  description = "IP access list entries to create."
  default     = []

  validation {
    condition = alltrue([
      for entry in var.entries : (
        can(cidrhost(entry.source, 0)) ||
        can(regex("^sg-[0-9a-fA-F]+$", entry.source)) ||
        can(cidrhost("${entry.source}/32", 0)) ||
        can(cidrhost("${entry.source}/128", 0))
      )
    ])
    error_message = "Each entry must be a valid CIDR block, IP address, or AWS security group ID (sg-...)."
  }

  validation {
    condition = alltrue([
      for entry in var.entries : (entry.skip_allow_all_validation || !contains(["0.0.0.0/0", "::/0"], entry.source))
    ])
    error_message = "Entries with source 0.0.0.0/0 or ::/0 are not allowed. Set skip_allow_all_validation = true on the entry to suppress this error."
  }
}
