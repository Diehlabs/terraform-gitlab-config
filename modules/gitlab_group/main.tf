locals {
  # group_path = var.path == null ? lower(replace(var.name, " ", "_")) : var.path
  group_path_sanitzed = var.path == null ? replace(var.name, " ", "-") : var.path
  group_path          = lower(local.group_path_sanitzed)
}

data "gitlab_group" "parent_group" {
  full_path = var.parent_group_name
}

# -----------------------------------------------------------------------------
# Create a Gitlab group.
# Use the group name for the path unless var.path is explicitly specified.
# https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group
# -----------------------------------------------------------------------------
resource "gitlab_group" "group" {
  name                          = var.name
  path                          = local.group_path
  description                   = var.description
  request_access_enabled        = var.request_access_enabled
  visibility_level              = var.visibility_level # ensure this is restricted to private or internal
  prevent_forking_outside_group = true
  parent_id                     = data.gitlab_group.parent_group.id
}

# -----------------------------------------------------------------------------
# Allow other groups to access this group
# -----------------------------------------------------------------------------
# share_groups = {
#   "verituity/devops" = "maintainer"
#   # full_path = group_access
# }

data "gitlab_group" "share" {
  for_each  = var.share_groups
  full_path = each.key
}

resource "gitlab_group_share_group" "all" {
  for_each       = data.gitlab_group.share
  group_id       = gitlab_group.group.id
  share_group_id = data.gitlab_group.share[each.key].id
  group_access   = var.share_groups[each.key]
}
