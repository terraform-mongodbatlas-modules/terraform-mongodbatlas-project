variable "project_name" {
  type        = string
  description = "The name of the MongoDB Atlas project."
  default     = "prod-secure-baseline"
}

variable "org_id" {
  type        = string
  description = "The ID of the MongoDB Atlas organization."
}
