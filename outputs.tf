output "groups" {
  description = "Object containing all groups created by this module."
  value = { for name, data in var.groups :
    name => module.gitlab_groups[name].group_obj
  }
}

output "projects" {
  description = "Object containing all projects created by this module."
  value = { for name, data in var.projects :
    name => module.gitlab_projects[name].project_obj
  }
}

# output "all_projects" {
#   description = "Debug data for locals object"
#   value       = local.all_projects
# }

# output "group_data" {
#   value = module.gitlab_groups
# }