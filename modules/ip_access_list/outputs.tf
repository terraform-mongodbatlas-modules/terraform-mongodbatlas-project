output "entries" {
  description = "Created project IP access list entry IDs."
  value = [
    for entry in mongodbatlas_project_ip_access_list.this : {
      id = entry.id
    }
  ]
}
