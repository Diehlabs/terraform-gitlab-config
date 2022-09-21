data "gitlab_group" "parent_group" {
  full_path = lower(
    replace(var.parent_group_name, " ", "-")
  )
}

data "gitlab_project" "template_project" {
  count               = try(var.template_project_path, null) == null ? 0 : 1
  path_with_namespace = var.template_project_path
}

# -----------------------------------------------------------------------------
# Create a deploy token
# https://docs.gitlab.com/ee/user/project/deploy_tokens/
# https://docs.gitlab.com/ee/user/project/deploy_keys/
# -----------------------------------------------------------------------------
# resource "gitlab_deploy_token" "deploy_token" {
#   project  = gitlab_project.project.id
#   name     = gitlab_project.project.name
#   username = lower(replace(gitlab_project.project.name, " ", "-"))
#   scopes   = ["read_repository", "read_registry", "read_package_registry", "write_registry", "write_package_registry"]
# }

# -----------------------------------------------------------------------------
# Store the deploy token in a project variable
# -----------------------------------------------------------------------------
# resource "gitlab_project_variable" "deploy_token" {
#   project           = gitlab_project.project.id
#   key               = "DEPLOY_TOKEN"
#   value             = gitlab_deploy_token.deploy_token.token
#   protected         = false
#   masked            = true
#   environment_scope = "*"
# }

# resource "gitlab_project_variable" "deploy_username" {
#   project           = gitlab_project.project.id
#   key               = "DEPLOY_USERNAME"
#   value             = gitlab_deploy_token.deploy_token.username
#   protected         = false
#   masked            = false
#   environment_scope = "*"
# }

# -----------------------------------------------------------------------------
# Configure branch protection
# https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/branch_protection
# -----------------------------------------------------------------------------
# resource "gitlab_branch_protection" "BranchProtect" {
#   project                      = "12345"
#   branch                       = "BranchProtected"
#   push_access_level            = "developer"
#   merge_access_level           = "developer"
#   unprotect_access_level       = "developer"
#   allow_force_push             = true
#   code_owner_approval_required = true
#   allowed_to_push {
#     user_id = 5
#   }
# }

# -----------------------------------------------------------------------------
# Protect each environment
# https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_protected_environment
# -----------------------------------------------------------------------------

# Example with access level
# resource "gitlab_project_protected_environment" "example_with_access_level" {
#   project     = gitlab_project_environment.this.project
#   environment = gitlab_project_environment.this.name

#   deploy_access_levels {
#     access_level = "developer"
#   }
# }

# -----------------------------------------------------------------------------
# Manage approval rules
# -----------------------------------------------------------------------------
# data "gitlab_group" "approvers" {
#   for_each  = toset(lookup(var.approval_rule, "groups", []))
#   full_path = each.value
# }

# data "gitlab_user" "approvers" {
#   for_each  = toset(lookup(var.approval_rule, "users", []))
#   username = each.key
# }

# locals {
#   approvers_users = [for user.id in data.gitlab_group.approvers]
# }


# -----------------------------------------------------------------------------
# Add a file to the repo on first run.
# This will ensure the main branch gets created properly.
# -----------------------------------------------------------------------------
# resource "gitlab_repository_file" "initial_commit" {
#   count          = var.create_init_file ? 1 : 0
#   project        = gitlab_project.empty[0].id
#   file_path      = ".gitlab-ci.yml"
#   branch         = var.default_branch
#   content        = "# This repository is managed by Terraform."
#   author_email   = "chris.diehl@verituity.com"
#   author_name    = "Terraform"
#   commit_message = "VSCO-0000 create repository"
#   lifecycle {
#     ignore_changes = [file_path, content, author_email, author_name, commit_message]
#   }
# }