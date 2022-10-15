locals {
  # default deployment environments to create for each project
  # if variables deployment_environments_* are default value (empty list), use default values
  deployment_environments = var.create_deployment_environments ? {
    production = var.deployment_environments_production == [] ? ["production", "staging"] : var.deployment_environments_production
    non_prod   = var.deployment_environments_non_prod == [] ? ["development"] : var.deployment_environments_non_prod
    } : {
    production = []
    non_prod   = []
  }

  # this value will be used by other resources to determine the resource to attach to, depending on which is created.
  # project = try(
  #   gitlab_project.empty[0],
  #   gitlab_project.from_template[0],
  # )
  project = gitlab_project.empty[0]

  only_allow_merge_if_pipeline_succeeds = anytrue([
    var.only_allow_merge_if_pipeline_succeeds,
    var.merge_pipelines_enabled
  ])

  project_name_sanitzed = lower(replace("${local.project.name}", " ", "-"))

}
