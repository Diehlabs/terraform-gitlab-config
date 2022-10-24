# -----------------------------------------------------------------------------
# Allow other groups to access this group
# -----------------------------------------------------------------------------
# share_groups = {
#   share_001 = {
#     group_path = "verituity/devops"
#     group_access  = "maintainer"
#   }
# }

# -----------------------------------------------------------------------------
# A data lookup is required.
# Can't pass in a group ID since the root module creates all groups in a for loop.
# -----------------------------------------------------------------------------
data "gitlab_group" "share" {
  for_each  = var.share_groups
  full_path = each.value.group_path
}

resource "gitlab_group_share_group" "all" {
  for_each       = var.share_groups
  group_id       = gitlab_group.group.id
  share_group_id = data.gitlab_group.share[each.key].id
  group_access   = each.value.group_access
}