# -----------------------------------------------------------------------------
# Allow other groups to access this group
# -----------------------------------------------------------------------------
data "gitlab_group" "share" {
  for_each  = var.share_groups
  full_path = each.key
}

# share_groups = {
#   "verituity/devops" = "maintainer"
#   # full_path = group_access
# }

# resource "gitlab_project_share_group" "all" {
#   for_each     = data.gitlab_group.share
#   project_id   = local.project.id
#   group_id     = data.gitlab_group.share[each.key].id
#   group_access = var.share_groups[each.key]
# }
