# -----------------------------------------------------------------------------
# Create CI badge for the project
# -----------------------------------------------------------------------------
resource "gitlab_project_badge" "project" {
  project   = local.project.id
  link_url  = "https://gitlab.com/${local.project.path_with_namespace}/commits/${local.project.default_branch}"
  image_url = "https://gitlab.com/${local.project.path_with_namespace}/badges/${local.project.default_branch}/pipeline.svg"
  name      = "CI"
}
