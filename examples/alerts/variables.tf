variable "project_name" {
  type        = string
  description = "The name of the MongoDB Atlas project."
  default     = "my-atlas-project"
}

variable "org_id" {
  type        = string
  description = "The ID of the MongoDB Atlas organization."
}
