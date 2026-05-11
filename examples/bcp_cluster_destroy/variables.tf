variable "project_name" {
  type        = string
  description = "Name of the MongoDB Atlas project."
}

variable "org_id" {
  type        = string
  description = "ID of the MongoDB Atlas organization."
}

variable "cluster_name" {
  type        = string
  description = "Name of the MongoDB Atlas cluster."
}

variable "bcp_authorized_email" {
  type        = string
  description = "Email address of the user authorized to update the Backup Compliance Policy."
}

variable "bcp_authorized_user_first_name" {
  type        = string
  description = "First name of the user authorized to update the Backup Compliance Policy."
}

variable "bcp_authorized_user_last_name" {
  type        = string
  description = "Last name of the user authorized to update the Backup Compliance Policy."
}
