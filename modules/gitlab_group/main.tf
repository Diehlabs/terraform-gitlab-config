locals {
  # group_path = var.path == null ? lower(replace(var.name, " ", "_")) : var.path
  group_path_sanitzed = var.path == null ? replace(var.name, " ", "-") : var.path
  group_path          = lower(local.group_path_sanitzed)
}

data "gitlab_group" "parent_group" {
  full_path = var.parent_group_name
}
