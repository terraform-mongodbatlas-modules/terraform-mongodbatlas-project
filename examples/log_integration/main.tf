module "atlas_project" {
  source = "../.."

  name   = var.project_name
  org_id = var.org_id

  log_integration = {
    splunk = [
      {
        log_types = ["MONGOD"]
        hec_token = var.splunk_hec_token
        hec_url   = var.splunk_hec_url
      },
    ]
    datadog = [
      {
        log_types = ["MONGOS"]
        api_key   = var.datadog_api_key
        region    = var.datadog_region
      },
    ]
    otel = [
      {
        log_types = ["MONGOD_AUDIT", "MONGOS_AUDIT"]
        endpoint  = var.otel_endpoint
        headers   = [{ name = "Authorization", value = var.otel_auth_header }]
      },
    ]
  }
}
