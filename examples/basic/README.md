# Basic MongoDB Atlas Project Example

This example demonstrates creating a MongoDB Atlas project with project settings, limits, IP access list entries, and tags.

## Prerequisites

- Terraform >= 1.0
- MongoDB Atlas account
- MongoDB Atlas organization ID
- MongoDB Atlas API credentials (Public and Private Key)

## What This Example Creates

This example creates a MongoDB Atlas project with:
- **Project Settings**: Extended storage sizes enabled
- **Project Limits**:
  - Maximum 50 clusters
  - Maximum 25 custom database access roles
- **IP Access List**:
  - One CIDR block entry with a comment
  - One IP address entry
- **Tags**: Environment and management tags

## Usage

### 1. Set MongoDB Atlas Credentials

Set your MongoDB Atlas credentials as environment variables:

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

# When done, destroy resources
terraform destroy
```

## Configuration Details

### Project Settings
```hcl
project_settings = {
  is_extended_storage_sizes_enabled = true
}
```
Enables extended storage sizes for this project. Other settings use Atlas defaults.

### Project Limits
```hcl
limits = {
  "atlas.project.deployment.clusters" = 50
  "atlas.project.security.databaseAccess.customRoles" = 25
}
```
Sets maximum limits for clusters and custom roles to control resource usage.

### IP Access List
```hcl
ip_access_list = [
  {
    entry   = "203.0.113.0/24"
    comment = "Office VPN"
  },
  {
    entry = "198.51.100.10"
  },
  {
    entry = "sg-0123456789abcdef0"
  }
]
```
Each entry can be a CIDR block, IP address, or AWS security group ID. Comments are optional.

### Tags
```hcl
tags = {
  Environment = "Development"
  ManagedBy   = "Terraform"
}
```
Tags help organize and identify the `mongodbatlas_project` resource.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_name | The name of the MongoDB Atlas project | `string` | `"my-atlas-project"` | no |
| org_id | The ID of the MongoDB Atlas organization | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| atlas_project | Complete MongoDB Atlas project details including id, name, settings, limits, and IP access list |
