# -----------------------------------------------------------------------------
# Create environments for the project.
# https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_environment
# -----------------------------------------------------------------------------
resource "gitlab_project_environment" "all" {
  for_each            = var.environments
  project             = local.project.id
  name                = each.value.name
  external_url        = each.value.external_url
  stop_before_destroy = true
}
