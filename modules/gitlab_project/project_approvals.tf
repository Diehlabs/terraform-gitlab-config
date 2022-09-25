# -----------------------------------------------------------------------------
# Configure merge request approval settings
# -----------------------------------------------------------------------------
resource "gitlab_project_level_mr_approvals" "mra" {
  count                                          = length(var.merge_request_approval_settings) == 0 ? 0 : 1
  project_id                                     = local.project.id
  reset_approvals_on_push                        = var.merge_request_approval_settings.reset_approvals_on_push
  disable_overriding_approvers_per_merge_request = var.merge_request_approval_settings.disable_overriding_approvers_per_merge_request
  merge_requests_author_approval                 = var.merge_request_approval_settings.merge_requests_author_approval
  merge_requests_disable_committers_approval     = var.merge_request_approval_settings.merge_requests_disable_committers_approval
}

resource "gitlab_project_approval_rule" "default" {
  project            = local.project.id
  name               = var.approval_rule.name
  approvals_required = var.approval_rule.approvals_required
  user_ids           = var.approval_rule.user_ids
  group_ids          = var.approval_rule.group_ids
}
