resource "gitlab_group_access_token" "gat" {
  for_each     = var.access_tokens
  group        = gitlab_group.group.id
  name         = lower(each.value.name)
  access_level = try(each.value.access_level, "owner")
  scopes       = try(each.value.scopes, ["api"])
}

resource "gitlab_group_access_token" "gat_cicd" {
  count        = var.create_group_access_token ? 1 : 0
  group        = gitlab_group.group.id
  name         = "Group access token for CICD"
  access_level = "developer"
  scopes       = ["api"]
}

resource "gitlab_group_variable" "gat" {
  count             = var.create_group_access_token ? 1 : 0
  group             = gitlab_group_access_token.gat_cicd[0].group
  key               = "GA_CICD_TOKEN"
  value             = gitlab_group_access_token.gat_cicd[0].token
  protected         = false
  masked            = true
  environment_scope = "*"
}