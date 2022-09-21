# should add a share_groups_default here so all groups and projects are shared with devops.
#   will need to ensure share group isn't the same as the group being shared since that throws an error.

locals {
  # If a main_branch is included in the variable defaults, use it otherwise use "main".
  # In the projects module below, it will use a specific one if specified for each project, otherwise use this value.
  main_branch = try(var.defaults.main_branch, "main")

  # these defaults will be applied or overridden based on first defaults and then project specifics passed in
  push_rules_default = {
    author_email_regex     = "@verituity\\.com$"
    commit_committer_check = false
    member_check           = false
    prevent_secrets        = false
    branch_name_regex      = "^(main|feature|hotfix|bugfix|release)\\/"
  }

  approval_rule_default = {
    name               = "Verituity Default"
    approvals_required = 1
    user_ids           = []
    group_ids          = []
  }

  project_level_mr_approvals_default = {
    reset_approvals_on_push                        = true
    disable_overriding_approvers_per_merge_request = true
    merge_requests_author_approval                 = false
    merge_requests_disable_committers_approval     = true
  }

  # Grant developer rights to the devops group for every project.
  share_groups_default = {
    "verituity/devops" = "developer"
  }

  # defaults for group access tokens created and stored as GA_CICD_TOKEN
  gitlab_group_access_token_scopes_default = ["read_api", "read_repository"]

  # Generate a new object that converts a group name to a full path when creating projects.
  all_projects = (
    {
      for name, proj in var.projects :
      name => merge(
        proj,
        {
          group_path = try(
            module.gitlab_groups[lookup(proj, "group_key_name", null)].full_path,
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
  parent_group_name = try(each.value.parent_group_name, var.defaults.group_path)
  # create_group_access_token = try(each.value.create_group_access_token, false)
  # gitlab_group_access_token_scopes = try(
  #   each.value.gitlab_group_access_token_scopes,
  #   local.gitlab_group_access_token_scopes_default,
  # )
}

# -----------------------------------------------------------------------------
# Create a group access token if var.groups[group key].create_group_access_token
# is specified and is set to true.
# The token will be stored as GA_CICD_TOKEN variable on the group by default.
# -----------------------------------------------------------------------------
module "group_access_tokens" {
  for_each = {
    for key, group in var.groups : key => module.gitlab_groups[key].id
    if try(group.create_group_access_token, false) == true
  }
  source   = "./modules/gitlab_ga_token"
  group_id = each.value
}

# -----------------------------------------------------------------------------
# Create all projects for all groups.
# -----------------------------------------------------------------------------
module "gitlab_projects" {
  source                                = "./modules/gitlab_project"
  for_each                              = local.all_projects
  name                                  = each.value.name
  description                           = each.value.description
  parent_group_name                     = each.value.group_path #try(module.gitlab_groups[lookup(each.value, "group_path", null)], var.defaults.group_path)
  default_branch                        = try(each.value.main_branch, local.main_branch)
  merge_method                          = try(each.value.merge_method, "merge")
  wiki_enabled                          = try(each.value.wiki_enabled, false)
  packages_enabled                      = try(each.value.packages_enabled, false)
  mirror                                = try(each.value.mirror, false)
  init_with_readme                      = try(each.value.init_with_readme, false)
  merge_trains_enabled                  = try(each.value.merge_trains_enabled, false)
  merge_pipelines_enabled               = try(each.value.merge_pipelines_enabled, true)
  request_access_enabled                = try(each.value.request_access_enabled, false)
  container_registry_enabled            = try(each.value.container_registry_enabled, false)
  external_wiki_url                     = try(each.value.external_wiki_url, null)
  environments                          = try(each.value.environments, {})
  pipeline_schedules                    = try(each.value.pipeline_schedules, {})
  pipelines_enabled                     = try(each.value.pipelines_enabled, true)
  project_variables                     = try(each.value.project_variables, {})
  lfs_enabled                           = try(each.value.lfs_enabled, false)
  issues_enabled                        = try(each.value.issues_enabled, false)
  remove_source_branch_after_merge      = try(each.value.remove_source_branch_after_merge, true)
  only_allow_merge_if_pipeline_succeeds = try(each.value.only_allow_merge_if_pipeline_succeeds, true)
  shared_runners_enabled                = try(each.value.shared_runners_enabled, true)
  create_deploy_token                   = try(each.value.create_deploy_token, false)
  deploy_token_scopes                   = try(each.value.shared_runners_enabled, ["read_repository", "read_registry", "read_package_registry"])
  merge_request_approval_settings = try(
    local.project_level_mr_approvals_default,
    var.defaults.project_level_mr_approvals_default,
    each.value.merge_request_approval_settings
  )
  approval_rule = merge(
    local.approval_rule_default,
    try(var.defaults.project.approval_rule, {}),
    try(each.value.project.approval_rule, {})
  )
  push_rules = merge(
    local.push_rules_default,
    try(var.defaults.project.push_rules, {}),
    try(each.value.project.push_rules, {})
  )

  depends_on = [module.gitlab_groups]
}
