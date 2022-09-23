locals {
  # default deployment environments to create for each project
  deployment_environments = var.create_deployment_environments ? {
    production = ["production", "qa", "staging"]
    non_prod   = ["dev"]
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
