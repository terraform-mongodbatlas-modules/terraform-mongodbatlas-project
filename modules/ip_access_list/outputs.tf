output "entries" {
  description = "Created project IP access list entry IDs."
  value = [
    for entry in values(mongodbatlas_project_ip_access_list.this) : {
      id = entry.id
    }
  ]
}

output "entry_keys" {
  description = "Keys used for IP access list entries."
  value       = sort(keys(mongodbatlas_project_ip_access_list.this))
}
