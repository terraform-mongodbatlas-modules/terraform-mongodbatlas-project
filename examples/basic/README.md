# Basic MongoDB Atlas Project Example

This example demonstrates creating a MongoDB Atlas project with minimal configuration.

## Prerequisites

- Terraform >= 1.0
- MongoDB Atlas account
- MongoDB Atlas API credentials

## Usage

1. Set your MongoDB Atlas credentials:

```bash
export MONGODB_ATLAS_PUBLIC_KEY="your-public-key"
export MONGODB_ATLAS_PRIVATE_KEY="your-private-key"
```

2. Create a `terraform.tfvars` file:

```hcl
project_name = "my-atlas-project"
org_id       = "your-org-id"
```

3. Run Terraform:

```bash
terraform init
terraform plan
terraform apply
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_name | The name of the MongoDB Atlas project | `string` | `"my-atlas-project"` | no |
| org_id | The ID of the MongoDB Atlas organization | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| project_id | The unique identifier for the project |
| project_name | The name of the project |
