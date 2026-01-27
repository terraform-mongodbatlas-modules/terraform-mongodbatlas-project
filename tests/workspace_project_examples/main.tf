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
  project_name_basic = "test-ws-basic-${random_string.suffix.id}"
  # tflint-ignore: terraform_unused_declarations
  project_name_dev = "test-ws-dev-${random_string.suffix.id}"
  # tflint-ignore: terraform_unused_declarations
  project_name_prod = "test-ws-prod-${random_string.suffix.id}"
}
