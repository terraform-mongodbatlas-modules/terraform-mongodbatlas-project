output "log_integration" {
  description = "Log integration IDs and types."
  value = concat(
    [for r in mongodbatlas_log_integration.datadog : { id = r.integration_id, type = r.type, log_types = r.log_types }],
    [for r in mongodbatlas_log_integration.splunk : { id = r.integration_id, type = r.type, log_types = r.log_types }],
    [for r in mongodbatlas_log_integration.otel : { id = r.integration_id, type = r.type, log_types = r.log_types }],
  )
}
