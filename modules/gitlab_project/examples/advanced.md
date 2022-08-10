# Basic example
* This example uses all values for optional inputs.
* The default values are specified for any parameter whose default value is not a blank value.
```hcl
# relies on the environment variable "GITLAB_TOKEN" being set to a valid Gitlab access token
provider "gitlab" {}

# define data here that's re-used multiple times
locals {
  default_branch_name = "main"
}

module "gitlab_project" {
  source            = "<ssh or https url to module repo>"
  # required parameters
  name                       = "microservice-golang-xyz"
  description                = "Repository for the xyz Golang microservice"
  parent_group_name          = "verituity/development"
  # optional parameters
  default_branch             = local.default_branch_name
  merge_method               = "merge"
  wiki_enabled               = false
  packages_enabled           = false
  mirror                     = false
  init_with_readme           = false
  merge_pipelines_enabled    = true
  request_access_enabled     = false
  container_registry_enabled = false
  disable_overriding_approvers_per_merge_request = true
  external_wiki_url          = "https://verituity.atlassian.net/wiki/spaces/REGISTRY/pages/
  1683619841/Developer+and+Engineer+Onboarding+Guide"
  environments = {
    prod = "https://www.google.com"
    qa = "https://www.yahoo.com"
    dev = "https://www.verituity.com"
  }

  push_rules = {
    branch_name_regex      = ""
    commit_message_regex   = ""
    member_check           = false
    author_email_regex     = "verituity\\.com$"
    commit_committer_check = true
  }

  pipeline_schedules = {
    main_sched = {
      description = "Used to schedule builds"
      ref         = local.default_branch_name
      cron        = "0 1 * * *"
    }
  }
  project_variables = {
    my_pipeline_variable = {
      value              = "this is not a secret"
      protected          = false
      masked             = false # default is true
      environment_scope = "*"
    }
    node_version = {
      value              = "18"
      protected          = false
      masked             = false # default is true
      environment_scope = "*"
    }
  }
  environments               = {}
  share_groups               = {}

}
```