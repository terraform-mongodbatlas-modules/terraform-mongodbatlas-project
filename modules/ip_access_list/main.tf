locals {
  normalized_entries = [
    for list_item in var.entries : {
      entry_value = trimspace(list_item.entry)
      comment     = try(list_item.comment, null)
      is_cidr     = can(cidrhost(trimspace(list_item.entry), 0))
      is_sg       = can(regex("^sg-[0-9a-fA-F]+$", trimspace(list_item.entry)))
    }
  ]

  normalized_keys = [
    for item in local.normalized_entries : (
      can(cidrhost(item.entry_value, 0)) ? "${cidrhost(item.entry_value, 0)}/${split("/", item.entry_value)[1]}" :
      can(cidrhost("${item.entry_value}/32", 0)) ? "${cidrhost("${item.entry_value}/32", 0)}/32" :
      can(cidrhost("${item.entry_value}/128", 0)) ? "${cidrhost("${item.entry_value}/128", 0)}/128" :
      lower(item.entry_value)
    )
  ]
}

resource "mongodbatlas_project_ip_access_list" "this" {
  count = length(local.normalized_entries)

  project_id = var.project_id
  comment    = local.normalized_entries[count.index].comment

  cidr_block         = local.normalized_entries[count.index].is_cidr ? local.normalized_entries[count.index].entry_value : null
  aws_security_group = local.normalized_entries[count.index].is_sg ? local.normalized_entries[count.index].entry_value : null
  ip_address         = (!local.normalized_entries[count.index].is_cidr && !local.normalized_entries[count.index].is_sg) ? local.normalized_entries[count.index].entry_value : null

  lifecycle {
    precondition {
      condition     = length(local.normalized_keys) == length(distinct(local.normalized_keys))
      error_message = "ip_access_list.entry values must be unique (IP and CIDR equivalents are considered duplicates)."
    }
  }
}
