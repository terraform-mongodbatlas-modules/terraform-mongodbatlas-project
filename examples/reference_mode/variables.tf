variable "project_id" {
  type        = string
  description = "ID of an existing MongoDB Atlas project."
}

variable "otel_endpoint" {
  type        = string
  description = "OTel collector endpoint (e.g. https://otel-collector.example.com:4318)."
}

variable "otel_auth_header" {
  type        = string
  description = "Authorization header value for the OTel collector."
  sensitive   = true
}
