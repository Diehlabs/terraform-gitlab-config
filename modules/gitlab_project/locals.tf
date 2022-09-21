locals {
  # this value will be used by other resources to determin the resource to attach to,
  # depending on which is created.
  project = try(
    gitlab_project.empty[0],
    gitlab_project.from_template[0],
  )

  project_name_sanitzed = lower(replace("${local.project.name}", " ", "-"))


}