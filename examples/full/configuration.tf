locals {
  defaults = {
    # group_path will be used as the namespace for all groups and Terratest unless one is specified a given resource.
    group_path = "diehlabs/gitlab-management/gitlab-terratest-sandbox"

    # push_rules will be used for all Terratest unless one is specified for a given Terratestect.
    project = {
      push_rules = {
        branch_name_regex = "^(defaultmainbranch|feature|hotfix|bugfix|release)\\/"
      }
      merge_request_approval_settings_default = {
        # allow overriding number of approvers per merge request
        disable_overriding_approvers_per_merge_request = false
      }
    }

  }

  projects = {
    project_1 = {
      name           = "Terratest Proj ${var.unique_id} One"
      description    = "Used by Terratest for terraform-gitlab-config module"
      group_key_name = "group_1"
    },
    project_2 = {
      name           = "Terratest Proj ${var.unique_id} Two"
      description    = "Used by Terratest for terraform-gitlab-config module"
      group_key_name = "group_2"
    },
    project_3 = {
      name           = "Terratest Proj ${var.unique_id} Simple"
      description    = "Used by Terratest for terraform-gitlab-config module"
      group_key_name = "group_2"
    },
    project_4 = local.all_options_proj
  }

  groups = {
    group_1 = {
      name        = "Terratest Group ${var.unique_id} One"
      description = "Terratest Group One"
    }
    group_2 = {
      name                      = "Terratest Group ${var.unique_id} Two"
      description               = "Terratest Group Two"
      create_group_access_token = true
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
    external_wiki_url                              = "https://diehlabs.atlassian.net/wiki/spaces/REGISTRY/pages/1683619841/Developer+and+Engineer+Onboarding+Guide"
    branch_name_regex                              = "^(prov04mainbranch|feature|hotfix|bugfix|release)\\/"
    create_deploy_token                            = true
    deploy_token_scopes                            = ["read_repository"]
    environments = {
      env_01 = {
        name         = "prod"
        external_url = "https://www.google.com"
      }
      env_02 = {
        name         = "qa"
        external_url = "https://www.yahoo.com"
      }
      env_03 = {
        name         = "dev"
        external_url = "https://www.diehlabs.com"
      }
    }
    push_rules = {
      # branch_name_regex      = "" # this will be inherited from local.defaults.project.push_rules in the config module
      # author_email_regex     = "" # this will be inherited from local.defaults.project.push_rules in the config module
      commit_message_regex   = ""
      member_check           = false
      commit_committer_check = false
    }
    pipeline_schedules = {
      schedule_01 = {
        description = "Used to schedule builds"
        ref         = "main"
        cron        = "0 1 * * *"
      }
    }
    merge_request_approval_settings = {
      reset_approvals_on_push                        = true
      disable_overriding_approvers_per_merge_request = true
      merge_requests_author_approval                 = false
      merge_requests_disable_committers_approval     = false
    }
  }

}
