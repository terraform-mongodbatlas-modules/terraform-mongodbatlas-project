locals {
  normalized_entries = [
    for item in var.entries : {
      entry   = trimspace(item.entry)
      
      comment = try(item.comment, null)
      is_cidr = can(cidrhost(entry, 0))
      is_sg   = can(regex("^sg-[0-9a-fA-F]+$", entry))
    }
  ]
}

resource "mongodbatlas_project_ip_access_list" "this" {
  for_each = {
    for idx, entry in local.normalized_entries : idx => entry
  }

  project_id = var.project_id
  comment    = each.value.comment

  cidr_block         = each.value.is_cidr ? each.value.entry : null
  aws_security_group = each.value.is_sg ? each.value.entry : null
  ip_address         = (!each.value.is_cidr && !each.value.is_sg) ? each.value.entry : null
}
