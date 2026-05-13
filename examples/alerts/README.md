<!-- @generated
WARNING: This file is auto-generated. Do not edit directly.
Changes will be overwritten when documentation is regenerated.
Run 'just gen-examples' to regenerate.
-->
# Alert Configuration for a Module-managed Project

The Alert Configuration example creates alert configurations alongside a module-managed project. The two alerts included in the example ("No partition" and "Disk partition usage") are based on the [MongoDB Atlas recommended alert configurations](https://www.mongodb.com/docs/atlas/architecture/current/monitoring-alerts/).

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
  version = "v0.2.0"

  name   = var.project_name
  org_id = var.org_id
}

resource "mongodbatlas_alert_configuration" "no_primary" {
  project_id = module.atlas_project.id
  event_type = "NO_PRIMARY"
  enabled    = true

  notification {
    type_name     = "GROUP"
    interval_min  = 5
    delay_min     = 0
    email_enabled = true
    roles         = ["GROUP_OWNER"]
  }
}

resource "mongodbatlas_alert_configuration" "disk_partition" {
  project_id = module.atlas_project.id
  event_type = "OUTSIDE_METRIC_THRESHOLD"
  enabled    = true

  metric_threshold_config {
    metric_name = "DISK_PARTITION_SPACE_USED_DATA"
    operator    = "GREATER_THAN"
    threshold   = 90
    units       = "RAW"
    mode        = "AVERAGE"
  }

  notification {
    type_name     = "GROUP"
    interval_min  = 60
    delay_min     = 0
    email_enabled = true
    roles         = ["GROUP_OWNER"]
  }
}
```

**Additional files needed:**
- [outputs.tf](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/blob/v0.2.0/examples/alerts/outputs.tf)
- [variables.tf](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/blob/v0.2.0/examples/alerts/variables.tf)
- [versions.tf](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/blob/v0.2.0/examples/alerts/versions.tf)



## Feedback or Help

- If you have any feedback or trouble please open a Github Issue
