# -----------------------------------------------------------------------------
# Configure merge request approval settings
# -----------------------------------------------------------------------------
resource "gitlab_project_level_mr_approvals" "mra" {
  project_id                                     = local.project.id
  reset_approvals_on_push                        = true
  disable_overriding_approvers_per_merge_request = false
  merge_requests_author_approval                 = false
  merge_requests_disable_committers_approval     = true
}
