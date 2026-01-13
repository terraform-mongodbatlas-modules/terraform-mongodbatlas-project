variable "name" {
  type        = string
  description = "The name of the MongoDB Atlas project."
}

variable "org_id" {
  type        = string
  description = "The ID of the MongoDB Atlas organization in which to create the project."
}
