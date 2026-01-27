terraform {
  required_version = ">= 1.9"

  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 2.1"
    }
  }
  provider_meta "mongodbatlas" {
    module_name    = "project"
    module_version = "local"
  }
}

provider "mongodbatlas" {}
