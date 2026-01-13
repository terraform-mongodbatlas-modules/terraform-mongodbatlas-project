# MongoDB Atlas Project Resource
# This is a placeholder for the baseline project module
# Full implementation will be added in a subsequent PR

resource "mongodbatlas_project" "this" {
  name   = var.name
  org_id = var.org_id
}
