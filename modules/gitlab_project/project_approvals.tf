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

# -----------------------------------------------------------------------------
# Note that if a project level approval rule is created outside of Terraform,
#   it will need to be imported. Something as simple as setting minimum approvers
#   to "1" will create the "any_approver" rule and then it must be imported.
#
# Get a list of existing rules:
# https://docs.gitlab.com/ee/api/merge_request_approvals.html#get-project-level-rules
#
# Import a rule:
# https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_approval_rule#import
# -----------------------------------------------------------------------------
resource "gitlab_project_approval_rule" "default" {
  project            = local.project.id
  name               = var.approval_rule.name
  approvals_required = var.approval_rule.approvals_required
  user_ids           = sort(var.approval_rule.user_ids)
  group_ids          = sort(var.approval_rule.group_ids)
  rule_type          = var.approval_rule.rule_type
}
