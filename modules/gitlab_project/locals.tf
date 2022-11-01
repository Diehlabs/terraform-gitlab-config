locals {
  # this value will be used by other resources to determine the resource to attach to, depending on which is created.
  # project = try(
  #   gitlab_project.empty[0],
  #   gitlab_project.from_template[0],
  # )
  project = gitlab_project.empty[0]

  project_name_sanitzed = lower(replace("${local.project.name}", " ", "-"))

  deploy_access_levels_development = try(var.deploy_access_levels_development, null)
  deploy_access_levels_staging     = try(var.deploy_access_levels_staging, null)
  deploy_access_levels_production  = try(var.deploy_access_levels_production, null)

}
