## (Unreleased)

BREAKING CHANGES:

* variable/tags: Changes default from `{}` to `null` to prevent plan diff on import ([#23](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/23))
* variable/with_default_alerts_settings: Changes default from `true` to `false`. If using the default value, set `with_default_alerts_settings = true` explicitly to avoid a plan error ([#24](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/24))

ENHANCEMENTS:

* module: Ignores `teams` attribute on project resource as it is deprecated and not module-managed ([#23](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-project/pull/23))

## 0.1.0 (January 29, 2026)

NOTES:

* module: Initial version
