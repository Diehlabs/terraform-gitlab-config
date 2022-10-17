locals {
  # group_path = var.path == null ? lower(replace(var.name, " ", "_")) : var.path
  group_path = lower(
    replace(var.path == null ? var.name : var.path, " ", "-")
  )
}

data "gitlab_group" "parent_group" {
  full_path = var.parent_group_name
}
