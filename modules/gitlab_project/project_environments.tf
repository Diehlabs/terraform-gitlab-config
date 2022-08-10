# -----------------------------------------------------------------------------
# Create environments for the project.
# https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_environment
# -----------------------------------------------------------------------------
resource "gitlab_project_environment" "all" {
  for_each            = var.environments
  project             = local.project.id
  name                = each.key
  external_url        = each.value
  stop_before_destroy = true
}
