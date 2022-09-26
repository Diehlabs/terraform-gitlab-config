locals {
  # default deployment environments to create for each project
  # if variables deployment_environments_* are default value (empty list), use default values
  deployment_environments = var.create_deployment_environments ? {
    production = var.deployment_environments_production == [] ? ["production", "qa", "staging"] : var.deployment_environments_production
    non_prod   = var.deployment_environments_non_prod == [] ? ["dev"] : var.deployment_environments_non_prod
    } : {
    production = []
    non_prod   = []
  }

  # this value will be used by other resources to determin the resource to attach to,
  # depending on which is created.
  project = try(
    gitlab_project.empty[0],
    gitlab_project.from_template[0],
  )

  project_name_sanitzed = lower(replace("${local.project.name}", " ", "-"))

  # Enable merge pipelines if specifically enabled, if pipelines are enabled, or default to disabled.
  # Enabling this will cause merge requests to hang forever waiting for pipeline status if there is no pipeline to run.
  only_allow_merge_if_pipeline_succeeds = try(var.only_allow_merge_if_pipeline_succeeds, false)

  merge_pipelines_enabled = try(var.merge_pipelines_enabled, var.pipelines_enabled, false)

}
