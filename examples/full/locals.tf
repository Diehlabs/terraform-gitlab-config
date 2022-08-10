locals {
  defaults = {
    # group_path will be used as the namespace for all groups and Terratestects unless one is specified a given resource.
    group_path = "verituity/gitlab-management/gitlab-terratest-sandbox"

    # push_rules will be used for all Terratestects unless one is specified for a given Terratestect.
    push_rules = {
      branch_name_regex = "^(main|feature|hotfix|bugfix|release)\\/"
    }
    # allow overriding number of approvers per merge request
    disable_overriding_approvers_per_mr = false
  }

  projects = {
    project_1 = {
      name        = "Terratest Proj ${var.unique_id} One"
      description = "Used by Terratest for terraform-gitlab-config module"
      group_name  = "Group ${var.unique_id} One"
    },
    project_2 = {
      name        = "Terratest Proj ${var.unique_id} Two"
      description = "Used by Terratest for terraform-gitlab-config module"
      group_name  = "Group ${var.unique_id} Two"
    },
    project_3 = {
      name        = "Terratest Proj ${var.unique_id} Simple"
      description = "Used by Terratest for terraform-gitlab-config module"
    },
    project_4 = local.all_options_proj
  }

  groups = {
    group_1 = {
      name        = "Terratest Group ${var.unique_id} One"
      description = "Terratest Group One"
    }
    group_2 = {
      name        = "Terratest Group ${var.unique_id} Two"
      description = "Terratest Group Two"
    }
  }

  # defining this here for readability
  all_options_proj = {
    name                                           = "Terratest ${var.unique_id} Complex"
    description                                    = "Used by Terratest for terraform-gitlab-config module"
    default_branch                                 = "main"
    merge_method                                   = "merge"
    wiki_enabled                                   = false
    packages_enabled                               = false
    mirror                                         = false
    init_with_readme                               = false
    merge_pipelines_enabled                        = true
    request_access_enabled                         = false
    container_registry_enabled                     = false
    disable_overriding_approvers_per_merge_request = true
    external_wiki_url                              = "https://verituity.atlassian.net/wiki/spaces/REGISTRY/pages/1683619841/Developer+and+Engineer+Onboarding+Guide"
    environments = {
      prod = "https://www.google.com"
      qa   = "https://www.yahoo.com"
      dev  = "https://www.verituity.com"
    }
    push_rules = {
      branch_name_regex      = ""
      commit_message_regex   = ""
      member_check           = false
      author_email_regex     = ""
      commit_committer_check = false
    }
    pipeline_schedules = {
      main_sched = {
        description = "Used to schedule builds"
        ref         = "main"
        cron        = "0 1 * * *"
      }
    }
  }

}
