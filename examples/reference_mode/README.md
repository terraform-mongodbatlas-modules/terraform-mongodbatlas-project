<!-- @generated
WARNING: This file is auto-generated. Do not edit directly.
Changes will be overwritten when documentation is regenerated.
Run 'just gen-examples' to regenerate.
-->
# Reference Mode (Existing Project)

The Reference Mode example manages standalone resources of an existing Atlas project without managing the project resource.

<!-- BEGIN_GETTING_STARTED -->
## Prerequisites

If you are familiar with Terraform and already have an organization configured in MongoDB Atlas, go to [commands](#commands).

To use MongoDB Atlas with Terraform, ensure you meet the following requirements:

1. Install [Terraform](https://developer.hashicorp.com/terraform/install) to run `terraform` [commands](#commands).
2. [Sign in](https://account.mongodb.com/account/login) to or [create](https://account.mongodb.com/account/register) your MongoDB Atlas Account.
3. Configure your [authentication](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs#authentication) method.
4. Use an existing [MongoDB Atlas organization](https://www.mongodb.com/docs/atlas/access/orgs-create-view-edit-delete/) and ensure you have permissions to create projects: `Organization Owner` or `Organization Project Creator`. To learn more about Atlas roles, see [Atlas User Roles](https://www.mongodb.com/docs/atlas/reference/user-roles/) in the Atlas documentation.

## Commands

Run the following commands to initialize and apply the module:

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

  project_id = var.project_id

  maintenance_window = {
    enabled     = true
    day_of_week = 7
    hour_of_day = 2
  }

  ip_access_list = [
    { source = "203.0.113.0/24", comment = "Office VPN" },
    { source = "198.51.100.10", comment = "Admin workstation" },
  ]

  log_integration = {
    otel = [
      {
        log_types = ["MONGOD"]
        endpoint  = var.otel_endpoint
        headers   = [{ name = "Authorization", value = var.otel_auth_header }]
      },
    ]
  }
}
```

**Additional files needed:**
- [outputs.tf](./outputs.tf)
- [variables.tf](./variables.tf)
- [versions.tf](./versions.tf)



## Feedback or Help

- If you have any feedback or trouble please open a Github Issue
