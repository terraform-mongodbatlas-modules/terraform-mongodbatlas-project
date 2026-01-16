variable "project_name" {
  type        = string
  description = "The name of the MongoDB Atlas project."
  default     = "dev-with-allowlist"
}

variable "org_id" {
  type        = string
  description = "The ID of the MongoDB Atlas organization."
}
