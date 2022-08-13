# -----------------------------------------------------------------------------
# Configure merge request approval settings
# -----------------------------------------------------------------------------
resource "gitlab_project_level_mr_approvals" "mra" {
  project_id                                     = local.project.id
  reset_approvals_on_push                        = var.merge_request_approval_settings.reset_approvals_on_push
  disable_overriding_approvers_per_merge_request = var.merge_request_approval_settings.disable_overriding_approvers_per_merge_request
  merge_requests_author_approval                 = var.merge_request_approval_settings.merge_requests_author_approval
  merge_requests_disable_committers_approval     = var.merge_request_approval_settings.merge_requests_disable_committers_approval
}
