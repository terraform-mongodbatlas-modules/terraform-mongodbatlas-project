resource "mongodbatlas_project_ip_access_list" "this" {
  comment    = var.comment
  cidr_block = var.cidr_block
  project_id = var.project_id
}
