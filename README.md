# MongoDB Atlas Project Terraform Module

This Terraform module creates and manages a MongoDB Atlas Project with configurable settings.

<!-- BEGIN_TOC -->
<!-- @generated
WARNING: This section is auto-generated. Do not edit directly.
Changes will be overwritten when documentation is regenerated.
Run 'just gen-readme' to regenerate. -->
- [Public Preview Note](#public-preview-note)
- [Disclaimer](#disclaimer)
- [Getting Started](#getting-started)
- [Examples](#examples)
- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
- [Required Variables](#required-variables)
- [Project Settings](#project-settings)
- [Project Limits](#project-limits)
- [Optional Variables](#optional-variables)
- [Outputs](#outputs)
- [License](#license)
<!-- END_TOC -->

## Public Preview Note

The MongoDB Atlas Project Module (Public Preview) simplifies Atlas project management and embeds MongoDB's best practices as intelligent defaults. This preview validates that these patterns meet the needs of most workloads without constant maintenance or rework. We welcome your feedback and contributions during this preview phase. MongoDB formally supports this module from its v1 release onwards.

<!-- BEGIN_DISCLAIMER -->
## Disclaimer

One of this project's primary objectives is to provide durable modules that support non-breaking migration and upgrade paths. The v0 release (public preview) of the MongoDB Atlas Project Module focuses on gathering feedback and refining the design. Upgrades from v0 to v1 may not be seamless. We plan to deliver a finalized v1 release early next year with long term upgrade support.  

<!-- END_DISCLAIMER -->
## Getting Started

<!-- BEGIN_GETTING_STARTED -->
<!-- @generated
WARNING: This section is auto-generated. Do not edit directly.
Changes will be overwritten when documentation is regenerated.
Run 'just gen-readme' to regenerate. -->
### Prerequisites

If you are familiar with Terraform and already have an organization configured in MongoDB Atlas, go to [commands](#commands).

To use MongoDB Atlas with Terraform, ensure you meet the following requirements:

1. Install [Terraform](https://developer.hashicorp.com/terraform/install) to be able to run `terraform` [commands](#commands).
2. [Sign in](https://account.mongodb.com/account/login) or [create](https://account.mongodb.com/account/register) your MongoDB Atlas Account.
3. Configure your [authentication](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs#authentication) method.
4. Use an existing [MongoDB Atlas organization](https://www.mongodb.com/docs/atlas/access/orgs-create-view-edit-delete/) and ensure you have permissions to create projects.

### Commands

```sh
terraform init # this will download the required providers and create a `terraform.lock.hcl` file.
# configure authentication env-vars (MONGODB_ATLAS_XXX)
# configure your `vars.tfvars` with required variables
terraform apply -var-file vars.tfvars
# cleanup
terraform destroy -var-file vars.tfvars
```

<!-- END_GETTING_STARTED -->

### Step-by-Step: Create a Basic Atlas Project

Follow these steps to set up a simple Atlas project using this module.

1. Create your Terraform files.

   You can copy the files directly from the ones provided in this module:

    - [examples/basic/main.tf](examples/basic/main.tf)
    - [examples/basic/variables.tf](examples/basic/variables.tf)
    - [examples/basic/outputs.tf](examples/basic/outputs.tf)
    - [examples/basic/versions.tf](examples/basic/versions.tf)

      The following code example shows a basic example of a `main.tf` file configuration:

      ```hcl
      module "atlas_project" {
        source  = "terraform-mongodbatlas-modules/project/mongodbatlas"

        name   = var.project_name
        org_id = var.org_id

        # Optional settings (safe defaults shown)
        project_settings = {
          is_extended_storage_sizes_enabled = true
        }

        # Optional limits (adjust as needed)
        limits = {
          "atlas.project.deployment.clusters"                 = 50,
          "atlas.project.security.databaseAccess.customRoles" = 25,
        }

        # Optional IP access list (example entries)
        ip_access_list = [
          { source = "203.0.113.0/24", comment = "Office VPN" },
          { source = "198.51.100.10" },
        ]

        # Optional tags
        tags = {
          Environment = "Development"
          ManagedBy   = "Terraform"
        }
      }
      ```

2. Prepare your [variable](#required-variables) values.

   Create a `vars.tfvars` file with the values you must provide at `apply` time:

      ```hcl
      project_name = "my-atlas-project"
      org_id       = "YOUR_ORG_ID" # e.g., 65def6ce0f722a1507105aa5
      ```

   See [Project Settings](#project-settings) for information on additional parameters you can configure.

3. Initialize and apply your configuration.

    ```sh
    terraform init
    terraform apply -var-file vars.tfvars
    ```

4. Review outputs to confirm your project details.

    ```sh
    terraform output
    ```

   You should see values such as `cluster_count`, `created_at`, `id`, and `maintenance_window`.

5. Iterate or clean up your configuration.

- To add features (limits, IP allowlist, maintenance window), edit the `main.tf` file and re-run the `terraform apply` command.
- To remove the resources, use the Getting Started cleanup command:

    ```sh
    terraform destroy -var-file vars.tfvars
    ```

<!-- BEGIN_TABLES -->
<!-- @generated
WARNING: This section is auto-generated. Do not edit directly.
Changes will be overwritten when documentation is regenerated.
Run 'just gen-readme' to regenerate. -->
## Examples

Feature | Name
--- | ---
Project Setup | [Basic Project with Settings and Limits](./examples/basic)
IP Access List | [Development Project with IP Allowlist](./examples/dev_with_allowlist)
Production Baseline | [Production Secure Baseline with Maintenance Window](./examples/prod_secure_baseline)

<!-- END_TABLES -->
<!-- BEGIN_TF_DOCS -->
<!-- @generated
WARNING: This section is auto-generated by terraform-docs. Do not edit directly.
Changes will be overwritten when documentation is regenerated.
Run 'just docs' to regenerate.
-->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9)

- <a name="requirement_mongodbatlas"></a> [mongodbatlas](#requirement\_mongodbatlas) (~> 2.1)

## Providers

The following providers are used by this module:

- <a name="provider_mongodbatlas"></a> [mongodbatlas](#provider\_mongodbatlas) (~> 2.1)

## Resources

The following resources are used by this module:

- [mongodbatlas_project.this](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/project) (resource)

<!-- BEGIN_TF_INPUTS_RAW -->
<!-- @generated
WARNING: This grouped inputs section is auto-generated. Do not edit directly.
Changes will be overwritten when documentation is regenerated.
Run 'just docs' to regenerate.
-->
## Required Variables

### name

Name of the MongoDB Atlas project.

Type: `string`

### org_id

ID of the MongoDB Atlas organization associated with the project.

Type: `string`


## Project Settings

Configure Atlas project feature settings.

### project_settings

Optional Atlas project feature settings. Unset values do not override Atlas defaults.

Type:

```hcl
object({
  is_schema_advisor_enabled             = optional(bool)
  is_collect_database_specifics_enabled = optional(bool)
  is_data_explorer_enabled              = optional(bool)
  is_performance_advisor_enabled        = optional(bool)
  is_realtime_performance_panel_enabled = optional(bool)
  is_extended_storage_sizes_enabled     = optional(bool)
})
```

Default: `{}`

### project_owner_id

Unique 24-hexadecimal digit string that identifies the Atlas user account with the Project Owner role on the specified project.

Type: `string`

Default: `null`

### with_default_alerts_settings

Flag that indicates whether to create the project with default alert settings.

Type: `bool`

Default: `true`

### region_usage_restrictions

Set to `GOV_REGIONS_ONLY` to restrict project to government regions. Defaults to standard regions. Cannot mix government and standard regions in the same project. See [MongoDB Atlas for Government](https://www.mongodb.com/docs/atlas/government/api/#creating-a-project).

Type: `string`

Default: `null`


## Project Limits

Configure project resource limits. See the [Atlas project limits documentation](https://www.mongodb.com/docs/atlas/reference/api-resources-spec/v2/#tag/Projects/operation/setProjectLimit) for details.

### limits

Optional Atlas project limits keyed by limit name. Limit name is the key, value is the limit value.

For example,

```hcl
limits = {
  "atlas.project.deployment.clusters" = 100
}
```

Type: `map(number)`

Default: `{}`


## Optional Variables

### ip_access_list

IP access list of entries for the Atlas project. Each "source" maps to one of the following: `cidrBlock`, `ipAddress`, or `awsSecurityGroup`.

Note: When using AWS security group IDs, the value must be known at plan time. If you create the ID in the same `apply` command, Terraform fails.

For example,

```hcl
ip_access_list = [
  { source = "203.0.113.0/24", comment = "Office VPN" },
  { source = "198.51.100.10" },
  { source = "sg-0123456789abcdef0" }
]
```

Type:

```hcl
list(object({
  source  = string
  comment = optional(string)
}))
```

Default: `[]`

### maintenance_window

Maintenance window configuration for the Atlas project.
- Typically, you don't need to manually configure a maintenance window. Atlas performs maintenance automatically in a rolling manner to preserve continuous availability for resilient applications. See [Cluster Maintenance Window](https://www.mongodb.com/docs/atlas/tutorial/cluster-maintenance-window/) in the MongoDB Atlas documentation for more information.
- To temporarily defer maintenance, use the Atlas CLI/API. See [Atlas `maintenanceWindows` defer](https://www.mongodb.com/docs/atlas/cli/current/command/atlas-maintenanceWindows-defer/#atlas-maintenancewindows-defer) in the MongoDB Atlas documentation for more information.

Type:

```hcl
object({
  enabled                 = bool
  day_of_week             = optional(number)
  hour_of_day             = optional(number)
  auto_defer              = optional(bool, false)
  auto_defer_once_enabled = optional(bool, false)
  protected_hours = optional(object({
    start_hour_of_day = number
    end_hour_of_day   = number
  }))
})
```

Default:

```json
{
  "enabled": false
}
```

### tags

Map of tags to assign to the project.

Type: `map(string)`

Default: `{}`

<!-- END_TF_INPUTS_RAW -->

## Outputs

The following outputs are exported:

### <a name="output_cluster_count"></a> [cluster\_count](#output\_cluster\_count)

Description: MongoDB Atlas project cluster count.

### <a name="output_created_at"></a> [created\_at](#output\_created\_at)

Description: MongoDB Atlas project creation time (RFC3339).

### <a name="output_id"></a> [id](#output\_id)

Description: MongoDB Atlas project ID.

### <a name="output_maintenance_window"></a> [maintenance\_window](#output\_maintenance\_window)

Description: Maintenance window details.
<!-- END_TF_DOCS -->

## License

See [LICENSE](LICENSE) for full details.
