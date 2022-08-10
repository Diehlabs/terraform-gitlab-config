output "groups" {
  sensitive = true
  description = "Object containing all groups created by this configuration."
  value = module.gitlab_config.groups
  # value = { for name, group in local.groups :
  #   name => module.gitlab_config[name].groups
  # }
}

output "projects" {
  sensitive = true
  description = "Object containing all projects created by this configuration."
  value = module.gitlab_config.projects
  #   value = { for name, project in local.projects :
  #   name => module.gitlab_config[name].projects
  # }
}