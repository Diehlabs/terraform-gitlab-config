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
