## (Unreleased)

BREAKING CHANGES:

* variable/tags: Changes default from `{}` to `null` to prevent plan diff on import ([#23](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/23))
* variable/with_default_alerts_settings: Changes default from `true` to `false`. If using the default value, set `with_default_alerts_settings = true` explicitly to avoid a plan error ([#24](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/24))

NOTES:

* module: Changes the project resource address from `mongodbatlas_project.this` to `mongodbatlas_project.this[0]`. No action required, a `moved` block handles this automatically ([#25](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/25))

ENHANCEMENTS:

* examples/alerts: Demonstrates how to create alerts for a module-managed project ([#26](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/26))
* module: Ignores `teams` attribute on project resource as it is deprecated and not module-managed ([#23](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/23))
* variable/project_id: Adds reference mode support. When set, the module manages standalone resources for an existing Atlas project without managing the project resource ([#25](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/25))

## 0.1.0 (January 29, 2026)

NOTES:

* module: Initial version
