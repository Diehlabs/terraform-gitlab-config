# -----------------------------------------------------------------------------
# Add optional pipeline variables to the project
# -----------------------------------------------------------------------------
resource "gitlab_project_variable" "all" {
  for_each          = var.project_variables
  project           = local.project.id
  key               = each.value.name
  value             = each.value.value
  protected         = lookup(each.value, "protected", false)
  masked            = lookup(each.value, "masked", true)
  environment_scope = lookup(each.value, "environment_scope", "*")
}
