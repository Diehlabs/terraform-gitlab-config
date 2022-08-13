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