locals {
  normalized_entries = [
    for list_item in var.entries : {
      entry_value = trimspace(list_item.entry)
      comment     = try(list_item.comment, null)
      is_cidr     = can(cidrhost(trimspace(list_item.entry), 0))
      is_sg       = can(regex("^sg-[0-9a-fA-F]+$", trimspace(list_item.entry)))
    }
  ]

  entries_by_key = {
    for normalized_entry in local.normalized_entries : normalized_entry.entry_value => normalized_entry
  }
}

resource "mongodbatlas_project_ip_access_list" "this" {
  for_each = local.entries_by_key

  project_id = var.project_id
  comment    = each.value.comment

  cidr_block         = each.value.is_cidr ? each.value.entry_value : null
  aws_security_group = each.value.is_sg ? each.value.entry_value : null
  ip_address         = (!each.value.is_cidr && !each.value.is_sg) ? each.value.entry_value : null
}
