terraform {
  required_version = ">= 1.10"

  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 2.15"
    }
  }
  provider_meta "mongodbatlas" {
    module_name    = "project"
    module_version = "local"
  }
}
