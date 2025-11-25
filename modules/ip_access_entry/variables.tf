variable "ip_access_entry" {
  type = object({
    comment    = optional(string)
    ip_address = string
    project_id = string
  })
  description = "Only use this for dev cluster to allow debugging. In production use private endpoints instead."
}
