# should add a share_groups_default here so all groups and projects are shared with devops.
#   will need to ensure share group isn't the same as the group being shared since that throws an error.

locals {
  # If a main_branch is included in the variable defaults, use it otherwise use "main".
  # In the projects module below, it will use a specific one if specified for each project, otherwise use this value.
  main_branch = try(var.defaults.main_branch, "main")

  deployments_default = {
    development = {
      required_approval_count = 0
      group_ids               = []
      gitlab_roles            = ["developer"]
    }

    staging = {
      required_approval_count = 2
      group_ids               = []
      gitlab_roles            = ["developer"]
    }

    production = {
      required_approval_count = 2
      group_ids               = []
      gitlab_roles            = ["maintainer"]
    }
  }

  # these defaults will be applied or overridden based on first defaults and then project specifics passed in
  push_rules_default = {
    author_email_regex     = "@diehlabs\\.com$"
    commit_committer_check = false
    member_check           = false
    prevent_secrets        = false
    branch_name_regex      = "^(main|feature|hotfix|bugfix|release)\\/"
  }

  approval_rule_default = {
    name               = "diehlabs Default"
    approvals_required = 1
    user_ids           = []
    group_ids          = []
    rule_type          = "regular"
  }

  merge_request_approval_settings_default = {
    reset_approvals_on_push                        = true
    disable_overriding_approvers_per_merge_request = true
    merge_requests_author_approval                 = false
    merge_requests_disable_committers_approval     = true
  }

  # Grant developer rights to the devops group for every project.


  # defaults for group access tokens created and stored as GA_CICD_TOKEN
  gitlab_group_access_token_scopes_default = ["read_api", "read_repository"]

}

data "gitlab_group" "main" {
  full_path = var.defaults.group_path
}

# -----------------------------------------------------------------------------
# Create all Gitlab groups first.
# -----------------------------------------------------------------------------
module "gitlab_groups" {
  source                    = "./modules/gitlab_group"
  for_each                  = var.groups
  name                      = each.value.name
  description               = try(each.value.description, "")
  path                      = try(each.value.path, null)
  share_groups              = try(each.value.share_groups, {})
  parent_group_name         = try(each.value.parent_group_name, var.defaults.group_path)
  access_tokens             = try(each.value.access_tokens, {})
  create_group_access_token = try(each.value.create_group_access_token, false)
  saml_links                = try(each.value.saml_links, var.defaults.groups.saml_links, {})
  group_variables           = try(each.value.group_variables, {})
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
# module "group_access_tokens" {
#   for_each = {
#     for key, group in var.groups : key => module.gitlab_groups[key].id
#     if try(group.create_group_access_token, false) == true
#   }
#   source   = "./modules/gitlab_ga_token"
#   group_id = each.value
# }

# -----------------------------------------------------------------------------
# Create all projects for all groups.
# -----------------------------------------------------------------------------
module "gitlab_projects" {
  source          = "./modules/gitlab_project"
  for_each        = var.projects
  name            = each.value.name
  description     = each.value.description
  parent_group_id = try(module.gitlab_groups[each.value.group_key_name].id, data.gitlab_group.main.id)
  # parent_group_name                  = try(module.gitlab_groups[each.value.group_key_name].full_path, var.defaults.group_path)
  path                               = lower(replace(try(each.value.path, each.value.name), " ", "-"))
  default_branch                     = try(each.value.main_branch, var.defaults.project.default_branch, local.main_branch)
  merge_method                       = try(each.value.merge_method, var.defaults.project.merge_method, "merge")
  wiki_enabled                       = try(each.value.wiki_enabled, false)
  packages_enabled                   = try(each.value.packages_enabled, var.defaults.project.packages_enabled, false)
  mirror                             = try(each.value.mirror, false)
  init_with_readme                   = try(each.value.init_with_readme, false)
  request_access_enabled             = try(each.value.request_access_enabled, false)
  container_registry_enabled         = try(each.value.container_registry_enabled, var.defaults.project.container_registry_enabled, false)
  external_wiki_url                  = try(each.value.external_wiki_url, null)
  create_deployment_environments     = try(each.value.create_deployment_environments, var.defaults.project.create_deployment_environments, false)
  deployment_environments_production = try(each.value.deployment_environments_production, var.defaults.project.deployment_environments_production, [])
  deployment_environments_non_prod   = try(each.value.deployment_environments_non_prod, var.defaults.project.deployment_environments_non_prod, [])
  pipeline_schedules                 = try(each.value.pipeline_schedules, {})
  pipelines_enabled                  = try(each.value.pipelines_enabled, var.defaults.project.pipelines_enabled, true)
  # Enable merge pipelines if specifically enabled, if pipelines are enabled, or default to disabled.
  # Enabling this will cause merge requests to hang forever waiting for pipeline status if there is no pipeline to run.
  merge_pipelines_enabled = try(each.value.merge_pipelines_enabled, var.defaults.project.merge_pipelines_enabled, true)
  only_allow_merge_if_pipeline_succeeds = try(
    each.value.only_allow_merge_if_pipeline_succeeds,
    var.defaults.project.only_allow_merge_if_pipeline_succeeds,
    each.value.merge_pipelines_enabled,
    var.defaults.project.merge_pipelines_enabled,
    false
  )
  merge_trains_enabled             = try(each.value.merge_trains_enabled, var.defaults.project.merge_trains_enabled, false)
  project_variables                = try(each.value.project_variables, {})
  lfs_enabled                      = try(each.value.lfs_enabled, false)
  issues_enabled                   = try(each.value.issues_enabled, false)
  remove_source_branch_after_merge = try(each.value.remove_source_branch_after_merge, var.defaults.project.remove_source_branch_after_merge, true)
  shared_runners_enabled           = try(each.value.shared_runners_enabled, true)
  create_deploy_token              = try(each.value.create_deploy_token, var.defaults.project.create_deploy_token, false)
  deploy_token_scopes              = try(each.value.deploy_token_scopes, ["read_repository", "read_registry", "read_package_registry"])
  squash_option                    = try(each.value.squash_option, var.defaults.project.squash_option, "default_on")
  deploy_access_levels_development = try(each.value.deployments.access_levels.development, var.defaults.deployments.access_levels.development, local.deployments_default.development)
  deploy_access_levels_staging     = try(each.value.deployments.access_levels.staging, var.defaults.deployments.access_levels.staging, local.deployments_default.staging)
  deploy_access_levels_production  = try(each.value.deployments.access_levels.production, var.defaults.deployments.access_levels.production, local.deployments_default.production)

  merge_request_approval_settings = merge(
    local.merge_request_approval_settings_default,
    try(var.defaults.project.merge_request_approval_settings_default, {}),
    try(each.value.merge_request_approval_settings, {})
  )
  approval_rule = merge(
    local.approval_rule_default,
    try(var.defaults.project.approval_rule, {}),
    try(each.value.approval_rule, {})
  )
  push_rules = merge(
    local.push_rules_default,
    try(var.defaults.project.push_rules, {}),
    try(each.value.project.push_rules, {})
  )

  teams_settings = {
    webhook                      = try(each.value.teams_settings.webhook, false)
    push_events                  = try(each.value.teams_settings.push_events, true)
    tag_push_events              = try(each.value.teams_settings.tag_push_events, true)
    notify_only_broken_pipelines = try(each.value.teams_settings.notify_only_broken_pipelines, true)
    merge_requests_events        = try(each.value.teams_settings.merge_requests_events, true)
    wiki_page_events             = try(each.value.teams_settings.wiki_page_events, false)
    branches_to_be_notified      = try(each.value.teams_settings.branches_to_be_notified, "protected")
  }

  depends_on = [module.gitlab_groups]
}
