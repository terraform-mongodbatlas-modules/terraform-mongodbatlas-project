module "atlas_project" {
  source = "../.."

  name   = var.project_name
  org_id = var.org_id

  project_settings = {
    is_extended_storage_sizes_enabled = true
  }

  limits = {
    "atlas.project.deployment.clusters"                 = 50,
    "atlas.project.security.databaseAccess.customRoles" = 25,
  }

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
