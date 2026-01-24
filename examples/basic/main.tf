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

  ip_access_list = [
    { source = "203.0.113.0/24", comment = "Office VPN" },
    { source = "198.51.100.10" },
  ]

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
