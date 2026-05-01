variable "project_name" {
  type        = string
  description = "Name of the MongoDB Atlas project."
}

variable "org_id" {
  type        = string
  description = "ID of the MongoDB Atlas organization."
}

variable "datadog_api_key" {
  type        = string
  description = "Datadog API key."
  sensitive   = true
}

variable "splunk_hec_token" {
  type        = string
  description = "Splunk HTTP Event Collector (HEC) token."
  sensitive   = true
}

variable "splunk_hec_url" {
  type        = string
  description = "Splunk HTTP Event Collector (HEC) endpoint URL including port (e.g. https://your-splunk-instance.com:8088)."
}

variable "datadog_region" {
  type        = string
  description = "Datadog region (e.g. US1, US3, US5, EU, AP1)."
  default     = "US1"
}

variable "otel_endpoint" {
  type        = string
  description = "OTel collector endpoint URL (e.g. https://otel-collector.example.com:4318)."
}

variable "otel_auth_header" {
  type        = string
  description = "Authorization header value for the OTel collector."
  sensitive   = true
}
