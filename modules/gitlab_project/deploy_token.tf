resource "gitlab_deploy_token" "default" {
  count    = var.create_deploy_token == false ? 0 : 1
  project  = local.project.path_with_namespace
  name     = "${local.project_name_sanitzed}_terraform"
  username = "gl-dt-${local.project_name_sanitzed}"
  scopes   = var.deploy_token_scopes
  # expires_at = "2020-03-14T00:00:00.000Z"
}