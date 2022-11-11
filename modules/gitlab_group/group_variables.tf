# -----------------------------------------------------------------------------
# Add optional pipeline variables to the group
# -----------------------------------------------------------------------------
resource "gitlab_group_variable" "all" {
  for_each          = var.group_variables
  group             = gitlab_group.group.id
  key               = each.value.name
  value             = each.value.value
  protected         = lookup(each.value, "protected", false)
  masked            = lookup(each.value, "masked", true)
  environment_scope = lookup(each.value, "environment_scope", "*")
}

# ex format:
/*
  name = {
    value = string * required
    protected bool *optional, false
    masked *optional, true
    environment_scope *optional, "*"
*/
