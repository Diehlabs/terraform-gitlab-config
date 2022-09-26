# -----------------------------------------------------------------------------
# Create environments for the project.
# https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_environment
# -----------------------------------------------------------------------------
resource "gitlab_project_environment" "non_prod" {
  for_each            = toset(local.deployment_environments.non_prod)
  project             = local.project.id
  name                = each.value
  stop_before_destroy = true
  # external_url      = try(each.value.external_url, "")
}

resource "gitlab_project_environment" "production" {
  for_each            = toset(local.deployment_environments.production)
  project             = local.project.id
  name                = each.value
  stop_before_destroy = true
  # external_url      = try(each.value.external_url, "")
}

# -----------------------------------------------------------------------------
# Create protected environments, aka define approvers for deployments.
# https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_protected_environment
# -----------------------------------------------------------------------------
resource "gitlab_project_protected_environment" "non_prod" {
  for_each                = gitlab_project_environment.non_prod
  project                 = each.value.project
  required_approval_count = 1
  environment             = each.value.name
  deploy_access_levels {
    access_level = "developer"
  }
}

resource "gitlab_project_protected_environment" "production" {
  for_each                = gitlab_project_environment.production
  project                 = each.value.project
  required_approval_count = 1
  environment             = each.value.name
  deploy_access_levels {
    access_level = "maintainer"
  }

}
