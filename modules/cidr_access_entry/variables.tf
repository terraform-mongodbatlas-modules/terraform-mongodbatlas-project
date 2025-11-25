variable "comment" {
  type        = string
  description = "Comment to add to the access list"
  default     = "Added by project module"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block to allow access to the project"
}

variable "project_id" {
  type = string
}
