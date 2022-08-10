output "name" {
  value = try(
    gitlab_project.empty[0].name,
    gitlab_project.from_template[0].name,
    null
  )
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

output "namespace_id" {
  description = "Namespace ID, i.e. the parent group ID"
  value       = data.gitlab_group.parent_group.id
}

output "path_with_namespace" {
  description = "The full path of the repository."
  value = try(
    gitlab_project.empty[0].path_with_namespace,
    gitlab_project.from_template[0].path_with_namespace,
    null
  )
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