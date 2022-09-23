resource "gitlab_deploy_token" "default" {
  count    = var.create_deploy_token == false ? 0 : 1
  project  = local.project.path_with_namespace
  name     = "${local.project_name_sanitzed}_terraform"
  username = "gl-dt-${local.project_name_sanitzed}"
  scopes   = var.deploy_token_scopes
  # expires_at = "2020-03-14T00:00:00.000Z"
}

resource "gitlab_project_variable" "gitlab_deploy_token_user" {
  count             = var.create_deploy_token == false ? 0 : 1
  project           = local.project.id
  key               = "deploy_token_user"
  value             = gitlab_deploy_token.default[0].username
  masked            = true
  environment_scope = "*"
  depends_on = [
    gitlab_deploy_token.default
  ]
}

resource "gitlab_project_variable" "gitlab_deploy_token" {
  count             = var.create_deploy_token == false ? 0 : 1
  project           = local.project.id
  key               = "deploy_token"
  value             = gitlab_deploy_token.default[0].token
  masked            = true
  environment_scope = "*"
  depends_on = [
    gitlab_deploy_token.default
  ]
}
