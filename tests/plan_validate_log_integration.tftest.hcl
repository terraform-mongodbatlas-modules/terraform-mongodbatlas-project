mock_provider "mongodbatlas" {}

variables {
  name   = "test-project"
  org_id = "000000000000000000000000"
}

run "log_integration_null_no_submodule" {
  command = plan
  assert {
    condition     = length(module.log_integration) == 0
    error_message = "Expected log_integration submodule to be disabled when null"
  }
}

run "log_integration_all_null_lists_no_submodule" {
  command = plan
  variables {
    log_integration = {}
  }
  assert {
    condition     = length(module.log_integration) == 0
    error_message = "Expected log_integration submodule to be disabled when all lists are null"
  }
}

run "log_integration_all_empty_lists_no_submodule" {
  command = plan
  variables {
    log_integration = { datadog = [], splunk = [], otel = [] }
  }
  assert {
    condition     = length(module.log_integration) == 0
    error_message = "Expected log_integration submodule to be disabled when all lists are empty"
  }
}

run "log_integration_otel" {
  command = plan
  variables {
    log_integration = {
      otel = [
        {
          log_types = ["MONGOD", "MONGOD_AUDIT"]
          endpoint  = "https://otel.example.com:4318"
          headers   = [{ name = "Authorization", value = "Bearer token" }]
        }
      ]
    }
  }
  assert {
    condition     = length(module.log_integration) == 1
    error_message = "Expected log_integration submodule to be instantiated"
  }
  assert {
    condition     = module.log_integration[0].log_integration[0].type == "OTEL_LOG_EXPORT"
    error_message = "Expected OTEL_LOG_EXPORT type"
  }
}

run "log_integration_datadog" {
  command = plan
  variables {
    log_integration = {
      datadog = [
        {
          log_types = ["MONGOD"]
          api_key   = "test-api-key"
          region    = "US1"
        }
      ]
    }
  }
  assert {
    condition     = length(module.log_integration) == 1
    error_message = "Expected log_integration submodule to be instantiated"
  }
  assert {
    condition     = module.log_integration[0].log_integration[0].type == "DATADOG_LOG_EXPORT"
    error_message = "Expected DATADOG_LOG_EXPORT type"
  }
}

run "log_integration_splunk" {
  command = plan
  variables {
    log_integration = {
      splunk = [
        {
          log_types = ["MONGOD"]
          hec_token = "test-token"
          hec_url   = "https://splunk.example.com:8088"
        }
      ]
    }
  }
  assert {
    condition     = length(module.log_integration) == 1
    error_message = "Expected log_integration submodule to be instantiated"
  }
  assert {
    condition     = module.log_integration[0].log_integration[0].type == "SPLUNK_LOG_EXPORT"
    error_message = "Expected SPLUNK_LOG_EXPORT type"
  }
}

run "log_integration_multiple_entries" {
  command = plan
  variables {
    log_integration = {
      otel = [
        {
          log_types = ["MONGOD"]
          endpoint  = "https://otel1.example.com:4318"
          headers   = [{ name = "Authorization", value = "Bearer token1" }]
        },
        {
          log_types = ["MONGOD_AUDIT"]
          endpoint  = "https://otel2.example.com:4318"
          headers   = [{ name = "Authorization", value = "Bearer token2" }]
        }
      ]
      datadog = [
        {
          log_types = ["MONGOS"]
          api_key   = "test-api-key"
          region    = "US1"
        }
      ]
    }
  }
  assert {
    condition     = length(module.log_integration[0].log_integration) == 3
    error_message = "Expected three log integration resources"
  }
}
