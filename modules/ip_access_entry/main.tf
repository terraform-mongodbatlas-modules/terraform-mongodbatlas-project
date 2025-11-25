resource "mongodbatlas_project_ip_access_list" "this" {
  comment    = var.ip_access_entry.comment
  ip_address = var.ip_access_entry.ip_address
  project_id = var.ip_access_entry.project_id
}
