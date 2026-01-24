module "atlas_project" {
  source = "../.."

  name   = var.project_name
  org_id = var.org_id

  ip_access_list = [
    {
      source  = "203.0.113.0/24"
      comment = "Office VPN"
    },
    {
      source = "198.51.100.10"
    }
  ]

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
