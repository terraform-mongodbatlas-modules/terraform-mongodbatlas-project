output "entries" {
  description = "Created project IP access list entries."
  value = [
    for entry in values(mongodbatlas_project_ip_access_list.this) : {
      id         = entry.id
      project_id = entry.project_id

      cidr_block         = try(entry.cidr_block, null)
      ip_address         = try(entry.ip_address, null)
      aws_security_group = try(entry.aws_security_group, null)

      comment = try(entry.comment, null)
    }
  ]
}
