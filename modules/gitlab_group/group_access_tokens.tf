resource "gitlab_group_access_token" "gat" {
  for_each     = var.access_tokens
  group        = gitlab_group.group.id
  name         = lower(each.value.name)
  access_level = try(each.value.access_level, "owner")
  scopes       = try(each.value.scopes, ["api"])
}
