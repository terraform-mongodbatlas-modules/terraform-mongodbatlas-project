<!-- This file is used to generate the examples/README.md files -->
# {{ .NAME }}

## Pre Requirements

If you are familiar with Terraform and already have an organization configured in MongoDB Atlas go to [commands](#commands).

To use MongoDB Atlas with Terraform, ensure you meet the following requirements:

1. Install [Terraform](https://developer.hashicorp.com/terraform/install) to be able to run the `terraform` commands.
2. Sign up for a [MongoDB Atlas Account](https://www.mongodb.com/products/integrations/hashicorp-terraform)
3. Configure [authentication](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs#authentication)
4. An existing [MongoDB Atlas Organization](https://www.mongodb.com/docs/atlas/access/manage-organizations/)

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

{{ .CODE_SNIPPET }}
{{ .PRODUCTION_CONSIDERATIONS }}

## Feedback or Help

- If you have any feedback or trouble please open a Github Issue
