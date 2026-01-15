# MongoDB Atlas Project Terraform Module

This Terraform module creates and manages a MongoDB Atlas Project with configurable settings.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_mongodbatlas"></a> [mongodbatlas](#requirement\_mongodbatlas) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mongodbatlas"></a> [mongodbatlas](#provider\_mongodbatlas) | 2.4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ip_access_list"></a> [ip\_access\_list](#module\_ip\_access\_list) | ./modules/ip_access_list | n/a |

## Resources

| Name | Type |
|------|------|
| [mongodbatlas_project.this](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/project) | resource |
| [mongodbatlas_project.this](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ip_access_list"></a> [ip\_access\_list](#input\_ip\_access\_list) | IP access list entries with optional comments. | <pre>list(object({<br/>    entry   = string<br/>    comment = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_limits"></a> [limits](#input\_limits) | Optional Atlas project limits keyed by limit name. Limit name is the key, value is the limit value. <br/>For example, <br/>limits = {<br/>  "atlas.project.deployment.clusters" = 100<br/>  } | `map(number)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the MongoDB Atlas project. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The ID of the MongoDB Atlas organization in which to create the project. | `string` | n/a | yes |
| <a name="input_project_owner_id"></a> [project\_owner\_id](#input\_project\_owner\_id) | Unique 24-hexadecimal digit string that identifies the Atlas user account to be granted the Project Owner role on the specified project. | `string` | `null` | no |
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | Optional Atlas project feature settings. Unset values do not override Atlas defaults. | <pre>object({<br/>    is_schema_advisor_enabled             = optional(bool)<br/>    is_collect_database_specifics_enabled = optional(bool)<br/>    is_data_explorer_enabled              = optional(bool)<br/>    is_performance_advisor_enabled        = optional(bool)<br/>    is_realtime_performance_panel_enabled = optional(bool)<br/>    is_extended_storage_sizes_enabled     = optional(bool)<br/>  })</pre> | `{}` | no |
| <a name="input_region_usage_restrictions"></a> [region\_usage\_restrictions](#input\_region\_usage\_restrictions) | Optional - set value to GOV\_REGIONS\_ONLY, Designates that this project can be used for government regions only.  If not set the project will default to standard regions.   You cannot deploy clusters across government and standard regions in the same project. AWS is the only cloud provider for AtlasGov.  For more information see [MongoDB Atlas for Government](https://www.mongodb.com/docs/atlas/government/api/#creating-a-project). | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to the project. | `map(string)` | `{}` | no |
| <a name="input_with_default_alerts_settings"></a> [with\_default\_alerts\_settings](#input\_with\_default\_alerts\_settings) | Flag that indicates whether to create the project with default alert settings. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_access_list"></a> [ip\_access\_list](#output\_ip\_access\_list) | Project IP access list entries. |
| <a name="output_project"></a> [project](#output\_project) | MongoDB Atlas project details |
| <a name="output_project_limits"></a> [project\_limits](#output\_project\_limits) | All project limits returned by Atlas for the project. Limit name is the key, value is a map of limit details. |
| <a name="output_project_settings"></a> [project\_settings](#output\_project\_settings) | All project settings returned by Atlas for the project |
<!-- END_TF_DOCS -->

## License

See [LICENSE](LICENSE) for full details.
