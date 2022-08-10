# should add a share_groups_default here so all groups and projects are shared with devops.
#   will need to ensure share group isn't the same as the group being shared since that throws an error.

locals {
  # If a main_branch is included in the variable defaults, use it otherwise use "main".
  # In the projects module below, it will use a specific one if specified for each project, otherwise use this value.
  main_branch = lookup(var.defaults, "main_branch", "main")

  # push_rules_default will be merged with any that are input to produce a full list of push rules for each project.
  push_rules_default = {
    author_email_regex     = "@verituity\\.com$"
    commit_committer_check = false
    member_check           = false
    prevent_secrets        = false
  }

  # Grant developer rights to the devops group for every project.
  share_groups_default = {
    "verituity/devops" = "developer"
  }

  # Generate a new object that converts a group name to a full path when creating projects.
  all_projects = (
    {
      for name, proj in var.projects :
      name => merge(
        proj,
        {
          group_path = try(
            module.gitlab_groups[lookup(proj, "group_name", null)].full_path,
            var.defaults.group_path,
          )
        }
      )
    }
  )

}
# -----------------------------------------------------------------------------
# Create all Gitlab groups first.
# -----------------------------------------------------------------------------
module "gitlab_groups" {
  source            = "./modules/gitlab_group"
  for_each          = var.groups
  name              = each.value.name
  description       = each.value.description
  share_groups      = lookup(each.value, "share_groups", {})
  parent_group_name = var.defaults.group_path
}

# -----------------------------------------------------------------------------
# Create all projects for all groups.
# -----------------------------------------------------------------------------
module "gitlab_projects" {
  source                                         = "./modules/gitlab_project"
  for_each                                       = local.all_projects
  name                                           = each.value.name
  description                                    = each.value.description
  parent_group_name                              = each.value.group_path #try(module.gitlab_groups[lookup(each.value, "group_path", null)], var.defaults.group_path)
  default_branch                                 = try(each.value.main_branch, local.main_branch)
  merge_method                                   = try(each.value.merge_method, "merge")
  wiki_enabled                                   = try(each.value.wiki_enabled, false)
  packages_enabled                               = try(each.value.packages_enabled, false)
  mirror                                         = try(each.value.mirror, false)
  init_with_readme                               = try(each.value.init_with_readme, false)
  merge_pipelines_enabled                        = try(each.value.merge_pipelines_enabled, true)
  request_access_enabled                         = try(each.value.request_access_enabled, false)
  container_registry_enabled                     = try(each.value.container_registry_enabled, false)
  disable_overriding_approvers_per_merge_request = try(each.value.disable_overriding_approvers_per_mr, true)
  external_wiki_url                              = try(each.value.external_wiki_url, null)
  environments                                   = try(each.value.environments, {})
  pipeline_schedules                             = try(each.value.pipeline_schedules, {})
  push_rules = merge(
    local.push_rules_default,
    lookup(var.defaults, "push_rules", {})
  )
  depends_on = [module.gitlab_groups]
}
