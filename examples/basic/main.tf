module "atlas_project" {
  source = "../.."

  name   = var.project_name
  org_id = var.org_id

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
