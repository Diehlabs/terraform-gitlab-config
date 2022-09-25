resource "gitlab_group_access_token" "gat_cicd" {
  group        = var.group_id
  name         = "Group access token for CICD"
  access_level = "developer"
  scopes       = var.gitlab_group_access_token_scopes
  # lifecycle {
  #   replace_triggered_by = [ time_rotating.gat.id ]
  # }
}

# replace_triggered_by seems to ignore the changed time_rotating resource...
# resource "time_rotating" "gat" {
#   rotation_minutes = 1
# }

resource "gitlab_group_variable" "gat" {
  count             = var.project_id == null ? 1 : 0
  group             = var.group_id
  key               = "GA_CICD_TOKEN"
  value             = gitlab_group_access_token.gat_cicd.token
  protected         = false
  masked            = true
  environment_scope = "*"
}

resource "gitlab_project_variable" "gat" {
  count             = var.project_id == null ? 0 : 1
  project           = var.project_id
  key               = "GA_CICD_TOKEN"
  value             = gitlab_group_access_token.gat_cicd.token
  protected         = false
  masked            = true
  environment_scope = "*"
}