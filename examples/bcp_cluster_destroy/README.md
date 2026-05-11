<!-- @generated
WARNING: This file is auto-generated. Do not edit directly.
Changes will be overwritten when documentation is regenerated.
Run 'just gen-examples' to regenerate.
-->
# Cluster Destruction with Backup Compliance Policy (BCP)

The Cluster Destruction with [Backup Compliance Policy](https://www.mongodb.com/docs/atlas/backup/cloud-backup/backup-compliance-policy/) example shows how to destroy a cluster when a BCP is active using the `skip_destroy` flag on the [backup schedule resource](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/cloud_backup_schedule). An active BCP prevents the deletion of backup schedules. Setting `skip_destroy = true` on the schedule resource removes it from the Terraform state on destroy without calling the Atlas API. The schedule is then removed in Atlas together with the cluster.

<!-- BEGIN_GETTING_STARTED -->
## Prerequisites

If you are familiar with Terraform and already have an organization configured in MongoDB Atlas, go to [commands](#commands).

To use MongoDB Atlas with Terraform, ensure you meet the following requirements:

1. Install [Terraform](https://developer.hashicorp.com/terraform/install) to run `terraform` [commands](#commands).
2. [Sign in](https://account.mongodb.com/account/login) to or [create](https://account.mongodb.com/account/register) your MongoDB Atlas Account.
3. Configure your [authentication](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs#authentication) method.
4. Use an existing [MongoDB Atlas organization](https://www.mongodb.com/docs/atlas/access/orgs-create-view-edit-delete/) and ensure you have permissions to create projects.

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

  name   = var.project_name
  org_id = var.org_id

  backup_compliance_policy = {
    authorized_email           = var.bcp_authorized_email
    authorized_user_first_name = var.bcp_authorized_user_first_name
    authorized_user_last_name  = var.bcp_authorized_user_last_name

    skip_default_policy_items = true

    policy_items = [
      { frequency_type = "hourly", frequency_interval = 6, retention_unit = "days", retention_value = 7 }
    ]
  }
}

# To destroy the cluster and backup schedule, remove or comment out the resources below and run `terraform apply`.

resource "mongodbatlas_advanced_cluster" "this" {
  project_id     = module.atlas_project.id
  name           = var.cluster_name
  cluster_type   = "REPLICASET"
  backup_enabled = true

  replication_specs = [{
    region_configs = [{
      priority      = 7
      provider_name = "AWS"
      region_name   = "US_EAST_1"
      electable_specs = {
        instance_size = "M10"
        node_count    = 3
      }
    }]
  }]
}

resource "mongodbatlas_cloud_backup_schedule" "this" {
  project_id   = mongodbatlas_advanced_cluster.this.project_id
  cluster_name = mongodbatlas_advanced_cluster.this.name

  policy_item_hourly {
    frequency_interval = 6
    retention_unit     = "days"
    retention_value    = 14
  }

  # Allows the resource destruction to succeed when a Backup Compliance Policy is active.
  # The schedule is retained in Atlas and removed when the cluster is deleted.
  skip_destroy = true
}
```

**Additional files needed:**
- [outputs.tf](./outputs.tf)
- [variables.tf](./variables.tf)
- [versions.tf](./versions.tf)



## Feedback or Help

- If you have any feedback or trouble please open a Github Issue
