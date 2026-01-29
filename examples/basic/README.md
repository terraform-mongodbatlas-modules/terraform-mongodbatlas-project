<!-- @generated
WARNING: This file is auto-generated. Do not edit directly.
Changes will be overwritten when documentation is regenerated.
Run 'just gen-examples' to regenerate.
-->
# Basic Project with Settings and Limits

<!-- BEGIN_GETTING_STARTED -->
## Prerequisites

If you are familiar with Terraform and already have an organization configured in MongoDB Atlas, go to [commands](#commands).

To use MongoDB Atlas with Terraform, ensure you meet the following requirements:

1. Install [Terraform](https://developer.hashicorp.com/terraform/install) to run `terraform` [commands](#commands).
2. [Sign in](https://account.mongodb.com/account/login) to or [create](https://account.mongodb.com/account/register) your MongoDB Atlas Account.
3. Configure your [authentication](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs#authentication) method.
4. Use an existing [MongoDB Atlas organization](https://www.mongodb.com/docs/atlas/access/orgs-create-view-edit-delete/) and ensure you have permissions to create projects.

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
  version = "v0.1.0"

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
```

**Additional files needed:**
- [outputs.tf](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/blob/v0.1.0/examples/basic/outputs.tf)
- [variables.tf](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/blob/v0.1.0/examples/basic/variables.tf)
- [versions.tf](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/blob/v0.1.0/examples/basic/versions.tf)



## Feedback or Help

- If you have any feedback or trouble please open a Github Issue
