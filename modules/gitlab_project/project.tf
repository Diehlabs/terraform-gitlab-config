# -----------------------------------------------------------------------------
# Create the project (repo).
# -----------------------------------------------------------------------------
resource "gitlab_project" "empty" {
  count = var.template_project_path == null ? 1 : 0
  # exclusive to non-templated projects
  import_url = var.import_url
  mirror     = var.mirror
  # identical to templated
  name                                  = var.name
  description                           = var.description
  namespace_id                          = data.gitlab_group.parent_group.id
  visibility_level                      = var.visibility_level
  default_branch                        = var.default_branch
  merge_method                          = var.merge_method
  shared_runners_enabled                = var.shared_runners_enabled
  only_allow_merge_if_pipeline_succeeds = local.only_allow_merge_if_pipeline_succeeds
  remove_source_branch_after_merge      = var.remove_source_branch_after_merge
  initialize_with_readme                = var.init_with_readme
  pipelines_enabled                     = var.pipelines_enabled
  issues_enabled                        = var.issues_enabled
  lfs_enabled                           = var.lfs_enabled
  merge_pipelines_enabled               = local.merge_pipelines_enabled
  merge_trains_enabled                  = var.merge_trains_enabled
  wiki_enabled                          = var.wiki_enabled
  wiki_access_level                     = var.wiki_enabled ? "private" : "disabled"
  request_access_enabled                = var.request_access_enabled
  packages_enabled                      = var.packages_enabled
  container_registry_enabled            = var.container_registry_enabled
  container_registry_access_level       = var.container_registry_enabled ? "private" : "disabled"
  public_builds                         = var.public_builds
  push_rules {
    branch_name_regex      = lookup(var.push_rules, "branch_name_regex", "")
    commit_message_regex   = lookup(var.push_rules, "commit_message_regex", "")
    member_check           = lookup(var.push_rules, "member_check", false)
    author_email_regex     = lookup(var.push_rules, "author_email_regex", "verituity\\.com$")
    commit_committer_check = lookup(var.push_rules, "commit_committer_check", true)
  }
}

# -----------------------------------------------------------------------------
# Create the project (repo) from template project.
# Can't combine with the gitlab_project.empty resource due to the API
#   throwing fits with the template related params
#   if you're not using a template project.
# -----------------------------------------------------------------------------
resource "gitlab_project" "from_template" {
  count = var.template_project_path == null ? 0 : 1
  # specifics for templated project
  template_name                   = data.gitlab_project.template_project[0].id
  group_with_project_templates_id = data.gitlab_project.template_project[0].namespace_id
  # identical to non-templated
  name                                  = var.name
  description                           = var.description
  namespace_id                          = data.gitlab_group.parent_group.id
  visibility_level                      = var.visibility_level
  default_branch                        = var.default_branch
  merge_method                          = var.merge_method
  shared_runners_enabled                = var.shared_runners_enabled
  only_allow_merge_if_pipeline_succeeds = local.only_allow_merge_if_pipeline_succeeds
  remove_source_branch_after_merge      = var.remove_source_branch_after_merge
  initialize_with_readme                = var.init_with_readme
  pipelines_enabled                     = var.pipelines_enabled
  issues_enabled                        = var.issues_enabled
  lfs_enabled                           = var.lfs_enabled
  merge_pipelines_enabled               = local.merge_pipelines_enabled
  merge_trains_enabled                  = var.merge_trains_enabled
  wiki_enabled                          = var.wiki_enabled
  wiki_access_level                     = var.wiki_enabled ? "private" : "disabled"
  request_access_enabled                = var.request_access_enabled
  packages_enabled                      = var.packages_enabled
  container_registry_enabled            = var.container_registry_enabled
  container_registry_access_level       = var.container_registry_enabled ? "private" : "disabled"
  public_builds                         = var.public_builds
  push_rules {
    branch_name_regex      = lookup(var.push_rules, "branch_name_regex", "")
    commit_message_regex   = lookup(var.push_rules, "commit_message_regex", "")
    member_check           = lookup(var.push_rules, "member_check", false)
    author_email_regex     = lookup(var.push_rules, "author_email_regex", "verituity\\.com$")
    commit_committer_check = lookup(var.push_rules, "commit_committer_check", true)
  }
}

# -----------------------------------------------------------------------------
# Create CI badge for the project
# -----------------------------------------------------------------------------
resource "gitlab_project_badge" "project" {
  project   = local.project.id
  link_url  = "https://gitlab.com/${local.project.path_with_namespace}/commits/${local.project.default_branch}"
  image_url = "https://gitlab.com/${local.project.path_with_namespace}/badges/${local.project.default_branch}/pipeline.svg"
  name      = "CI"
}
