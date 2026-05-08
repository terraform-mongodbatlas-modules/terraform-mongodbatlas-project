terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 2.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.9"
}

provider "mongodbatlas" {}

# tflint-ignore: terraform_unused_declarations
variable "org_id" {
  type    = string
  default = ""
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

locals {
  # tflint-ignore: terraform_unused_declarations
  project_name_basic = "test-acc-tf-p-basic-${random_string.suffix.id}"
  # tflint-ignore: terraform_unused_declarations
  project_name_dev = "test-acc-tf-p-dev-${random_string.suffix.id}"
  # tflint-ignore: terraform_unused_declarations
  project_name_prod = "test-acc-tf-p-prod-${random_string.suffix.id}"
  # tflint-ignore: terraform_unused_declarations
  project_name_alerts = "test-acc-tf-p-alerts-${random_string.suffix.id}"
  # tflint-ignore: terraform_unused_declarations
  project_name_log_integration = "test-acc-tf-p-log-integration-${random_string.suffix.id}"
  # tflint-ignore: terraform_unused_declarations
  project_name_all_enabled = "test-acc-tf-p-all-enabled-${random_string.suffix.id}"
  # tflint-ignore: terraform_unused_declarations
  project_name_all_disabled = "test-acc-tf-p-all-disabled-${random_string.suffix.id}"
}
