<!-- This file is used to generate the examples/README.md files -->
# {{ .NAME }}

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
{{ .PRODUCTION_CONSIDERATIONS_COMMENT }}
terraform apply -var-file vars.tfvars
# cleanup
terraform destroy -var-file vars.tfvars
```
<!-- END_GETTING_STARTED -->

{{ .CODE_SNIPPET }}
{{ .PRODUCTION_CONSIDERATIONS }}

## Feedback or Help

- If you have any feedback or trouble please open a Github Issue
