output "name" {
  value = local.project.name
}

output "id" {
  value = try(
    gitlab_project.empty[0].id,
    gitlab_project.from_template[0].id,
    null
  )
}

output "default_branch" {
  value = try(
    gitlab_project.empty[0].default_branch,
    gitlab_project.from_template[0].default_branch,
    null
  )
}

# output "namespace_id" {
#   description = "Namespace ID, i.e. the parent group ID"
#   value       = data.gitlab_group.parent_group.id
# }

output "path_with_namespace" {
  description = "The full path of the repository."
  value       = local.project.path_with_namespace
}

output "path" {
  description = "The path of the repository."
  value = try(
    gitlab_project.empty[0].path,
    gitlab_project.from_template[0].path,
    null
  )
}

# -----------------------------------------------------------------------------
# Added try function due to odd behavior. May or may not be the actual solution.
# -----------------------------------------------------------------------------
output "namespace" {
  description = "The namespace of the repository."
  value = try(
    replace(gitlab_project.empty[0].path_with_namespace, "/${gitlab_project.empty[0].path}", ""),
    replace(gitlab_project.from_template[0].path_with_namespace, "/${gitlab_project.from_template[0].path}", ""),
    null
  )
}

output "project_obj" {
  description = "The entire project object that was created."
  value = try(
    gitlab_project.empty[0],
    gitlab_project.from_template[0],
    null
  )
}

output "create_deploy_token" {
  description = "A deploy token scoped to this project."
  sensitive   = true
  value       = try(gitlab_deploy_token.default[0].token, null)
}

output "create_deploy_token_username" {
  description = "The name token scoped to this project."
  value       = try(gitlab_deploy_token.default[0].username, null)
}
