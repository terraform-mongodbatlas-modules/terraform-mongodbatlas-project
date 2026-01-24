locals {
  normalized_entries = [
    for list_item in var.entries : {
      source_value = trimspace(list_item.source)
      comment     = try(list_item.comment, null)
      is_cidr     = can(cidrhost(trimspace(list_item.source), 0))
      is_sg       = can(regex("^sg-[0-9a-fA-F]+$", trimspace(list_item.source)))
    }
  ]

  normalized_keys = [
    for item in local.normalized_entries : (
      can(cidrhost(item.source_value, 0)) ? "${cidrhost(item.source_value, 0)}/${split("/", item.source_value)[1]}" :
      can(cidrhost("${item.source_value}/128", 0)) ? "${cidrhost("${item.source_value}/128", 0)}/128" :
      can(cidrhost("${item.source_value}/32", 0)) ? "${cidrhost("${item.source_value}/32", 0)}/32" :
      lower(item.source_value)
    )
  ]

  entries_by_key = {
    for item in local.normalized_entries : item.source_value => item
  }
}

resource "mongodbatlas_project_ip_access_list" "this" {
  for_each = local.entries_by_key

  project_id = var.project_id
  comment    = each.value.comment

  cidr_block         = each.value.is_cidr ? each.value.source_value : null
  aws_security_group = each.value.is_sg ? each.value.source_value : null
  ip_address         = (!each.value.is_cidr && !each.value.is_sg) ? each.value.source_value : null

  lifecycle {
    precondition {
      condition     = length(local.normalized_keys) == length(distinct(local.normalized_keys))
      error_message = "ip_access_list.source values must be unique (IP and CIDR equivalents are considered duplicates)."
    }
  }
}
