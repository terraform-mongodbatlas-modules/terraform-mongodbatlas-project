variable "project_id" {
  type        = string
  description = "The MongoDB Atlas project ID."
}

variable "datadog" {
  description = "List of Datadog log integration configurations. Each entry creates a mongodbatlas_log_integration resource of type DATADOG_LOG_EXPORT."
  type = list(object({
    log_types = list(string)
    api_key   = string
    region    = string
  }))
  nullable = false
  default  = []
}

variable "splunk" {
  description = "List of Splunk log integration configurations. Each entry creates a mongodbatlas_log_integration resource of type SPLUNK_LOG_EXPORT."
  type = list(object({
    log_types = list(string)
    hec_token = string
    hec_url   = string
  }))
  nullable = false
  default  = []
}

variable "otel" {
  description = "List of OTel log integration configurations. Each entry creates a mongodbatlas_log_integration resource of type OTEL_LOG_EXPORT."
  type = list(object({
    log_types = list(string)
    endpoint  = string
    headers   = list(object({ name = string, value = string }))
  }))
  nullable = false
  default  = []
}
