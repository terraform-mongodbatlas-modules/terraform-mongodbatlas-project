resource "mongodbatlas_log_integration" "datadog" {
  count      = length(var.datadog)
  project_id = var.project_id
  type       = "DATADOG_LOG_EXPORT"
  log_types  = var.datadog[count.index].log_types

  api_key = var.datadog[count.index].api_key
  region  = var.datadog[count.index].region
}

resource "mongodbatlas_log_integration" "splunk" {
  count      = length(var.splunk)
  project_id = var.project_id
  type       = "SPLUNK_LOG_EXPORT"
  log_types  = var.splunk[count.index].log_types

  hec_token = var.splunk[count.index].hec_token
  hec_url   = var.splunk[count.index].hec_url
}

resource "mongodbatlas_log_integration" "otel" {
  count      = length(var.otel)
  project_id = var.project_id
  type       = "OTEL_LOG_EXPORT"
  log_types  = var.otel[count.index].log_types

  otel_endpoint         = var.otel[count.index].endpoint
  otel_supplied_headers = var.otel[count.index].headers
}
