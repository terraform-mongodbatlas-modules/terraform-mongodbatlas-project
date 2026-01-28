<!-- @generated
WARNING: This file is auto-generated. Do not edit directly.
Changes will be overwritten when documentation is regenerated.
Run 'just gen-examples' to regenerate.
-->
# Production Secure Baseline with Maintenance Window

<!-- BEGIN_GETTING_STARTED -->
## Prerequisites

If you are familiar with Terraform and already have an organization configured in MongoDB Atlas, go to [commands](#commands).

To use MongoDB Atlas with Terraform, ensure you meet the following requirements:

1. Install [Terraform](https://developer.hashicorp.com/terraform/install) to be able to run `terraform` [commands](#commands).
2. [Sign in](https://account.mongodb.com/account/login) or [create](https://account.mongodb.com/account/register) your MongoDB Atlas Account.
3. Configure your [authentication](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs#authentication) method.
4. Use an existing [MongoDB Atlas organization](https://www.mongodb.com/docs/atlas/access/manage-organizations/) and ensure you have permissions to create projects.

## Commands

```sh
terraform init # this will download the required providers and create a `terraform.lock.hcl` file.
# configure authentication env-vars (MONGODB_ATLAS_XXX)
# configure your `vars.tfvars` with required variables
terraform apply -var-file vars.tfvars
# cleanup
terraform destroy -var-file vars.tfvars
```
<!-- END_GETTING_STARTED -->

## Code Snippet

Copy and use this code to get started quickly:

**main.tf**
```hcl
module "atlas_project" {
  source  = "terraform-mongodbatlas-modules/project/mongodbatlas"

  name   = var.project_name
  org_id = var.org_id

  project_settings = {
    is_data_explorer_enabled          = false
    is_performance_advisor_enabled    = true
    is_extended_storage_sizes_enabled = true
  }

  limits = {
    "atlas.project.deployment.clusters"                 = 100
    "atlas.project.security.databaseAccess.customRoles" = 50
  }

  ip_access_list = [
    { source = "203.0.113.0/24", comment = "Office VPN" },
    { source = "198.51.100.10", comment = "Admin workstation" }
  ]

  maintenance_window = {
    enabled     = true
    day_of_week = 6
    hour_of_day = 2
    auto_defer  = false

    protected_hours = {
      start_hour_of_day = 18
      end_hour_of_day   = 23
    }
  }

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Tier        = "baseline"
  }
}
```

**Additional files needed:**
- [outputs.tf](./outputs.tf)
- [variables.tf](./variables.tf)
- [versions.tf](./versions.tf)



## Feedback or Help

- If you have any feedback or trouble please open a Github Issue
