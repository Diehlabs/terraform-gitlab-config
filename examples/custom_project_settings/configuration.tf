locals {
  defaults = {
    # group_path will be used as the namespace for all groups and Terratest unless one is specified a given resource.
    group_path = "verituity/gitlab-management/gitlab-terratest-sandbox"

    # push_rules will be used for all Terratest unless one is specified for a given Terratestect.
    project = {
      merge_request_approval_settings_default = {
        reset_approvals_on_push                        = true
        disable_overriding_approvers_per_merge_request = true
        merge_requests_author_approval                 = true
        merge_requests_disable_committers_approval     = true
      }
    }

  }

  projects = {
    project_0 = local.custom_proj_settings # all merge_request_approval_settings should be FALSE
    project_1 = {
      # all merge_request_approval_settings should be TRUE
      group_key_name                 = "group_0"
      name                           = "Terratest ${var.unique_id} Custom 1"
      description                    = "Used by Terratest for terraform-gitlab-config module"
      create_deployment_environments = false
    }
    project_2 = {
      # all merge_request_approval_settings should be TRUE
      group_key_name = "group_0"
      name           = "Terratest ${var.unique_id} Custom 2"
      description    = "Used by Terratest for terraform-gitlab-config module"
      approval_rule = {
        name               = "Terratest ${var.unique_id} Custom"
        approvals_required = 2
        user_ids           = []
        group_ids          = []
      }
    }
  }

  groups = {
    group_0 = {
      name        = "Terratest Group ${var.unique_id} Custom"
      description = "Terratest Group One"
    }
  }

  # defining this here for readability
  custom_proj_settings = {
    group_key_name = "group_0"
    name           = "Terratest ${var.unique_id} Custom 0"
    description    = "Used by Terratest for terraform-gitlab-config module"
    push_rules = {
      # branch_name_regex      = "" # this will be inherited from local.defaults.project.push_rules in the config module
      # author_email_regex     = "" # this will be inherited from local.defaults.project.push_rules in the config module
      commit_message_regex   = ""
      member_check           = false
      commit_committer_check = false
    }
    merge_request_approval_settings = {
      reset_approvals_on_push                        = false
      disable_overriding_approvers_per_merge_request = false
      merge_requests_author_approval                 = false
      merge_requests_disable_committers_approval     = false
    }
  }

}
