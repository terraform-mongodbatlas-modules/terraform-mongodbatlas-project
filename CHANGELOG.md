## (Unreleased)

BREAKING CHANGES:

* variable/ip_access_list: Adds validation that rejects allow-all entries ("0.0.0.0/0" & "::/0"), suppressible via skip_allow_all_validation ([#31](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/31))
* variable/tags: Changes default from `{}` to `null` to prevent plan diff on import ([#23](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/23))
* variable/with_default_alerts_settings: Changes default from `true` to `false`. If using the default value, set `with_default_alerts_settings = true` explicitly to avoid a plan error ([#24](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/24))

NOTES:

* module: Changes the project resource address from `mongodbatlas_project.this` to `mongodbatlas_project.this[0]`. No action required, a `moved` block handles this automatically ([#25](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/25))
* provider/mongodbatlas: Requires minimum version 2.8.0 for mongodbatlas_log_integration resource support ([#28](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/28))

ENHANCEMENTS:

* examples/alerts: Demonstrates how to create alerts for a module-managed project ([#26](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/26))
* examples/log_integration: Demonstrates how to export Atlas logs to Datadog, Splunk and OpenTelemetry collectors ([#33](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/33))
* module: Ignores `teams` attribute on project resource as it is deprecated and not module-managed ([#23](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/23))
* submodule/backup_compliance_policy: Adds backup compliance policy submodule to manage `mongodbatlas_backup_compliance_policy` with Architecture Center defaults ([#30](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/30))
* submodule/log_integration: Adds log integration submodule for exporting Atlas logs to Datadog, Splunk, and/or OTel collectors via mongodbatlas_log_integration ([#28](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/28))
* variable/backup_compliance_policy: Adds backup compliance policy support with Architecture Center defaults ([#30](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/30))
* variable/default_feature_set: Adds mechanism to control which module features with default values are automatically enabled ([#27](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/27))
* variable/log_integration: Adds log integration support for exporting Atlas logs to Datadog, Splunk, and/or OTel collectors ([#28](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/28))
* variable/project_id: Adds reference mode support. When set, the module manages standalone resources for an existing Atlas project without managing the project resource ([#25](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/25))

## 0.1.0 (January 29, 2026)

NOTES:

* module: Initial version
