# -----------------------------------------------------------------------------
# Create environments for the project.
# https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_environment
# -----------------------------------------------------------------------------
resource "gitlab_project_environment" "development" {
  count               = var.create_deployment_environments ? 1 : 0
  project             = local.project.id
  name                = "development"
  stop_before_destroy = true
  # external_url      = try(each.value.external_url, "")
}

resource "gitlab_project_environment" "staging" {
  count               = var.create_deployment_environments ? 1 : 0
  project             = local.project.id
  name                = "staging"
  stop_before_destroy = true
  # external_url      = try(each.value.external_url, "")
}

resource "gitlab_project_environment" "production" {
  count               = var.create_deployment_environments ? 1 : 0
  project             = local.project.id
  name                = "production"
  stop_before_destroy = true
  # external_url      = try(each.value.external_url, "")
}

# -----------------------------------------------------------------------------
# Create protected environments, aka define approvers for deployments.
# https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_protected_environment
# -----------------------------------------------------------------------------
resource "gitlab_project_protected_environment" "development" {
  count                   = var.create_deployment_environments ? 1 : 0
  project                 = local.project.id
  required_approval_count = local.deploy_access_levels_development.required_approval_count
  environment             = gitlab_project_environment.development[0].name

  dynamic "deploy_access_levels" {
    for_each = local.deploy_access_levels_development.group_ids
    content {
      group_id = deploy_access_levels.value
    }
  }

  dynamic "deploy_access_levels" {
    for_each = local.deploy_access_levels_development.gitlab_roles
    content {
      access_level = deploy_access_levels.value
    }
  }
}

resource "gitlab_project_protected_environment" "staging" {
  count                   = var.create_deployment_environments ? 1 : 0
  project                 = local.project.id
  required_approval_count = local.deploy_access_levels_staging.required_approval_count
  environment             = gitlab_project_environment.staging[0].name

  dynamic "deploy_access_levels" {
    for_each = local.deploy_access_levels_staging.group_ids
    content {
      group_id = deploy_access_levels.value
    }
  }

  dynamic "deploy_access_levels" {
    for_each = local.deploy_access_levels_staging.gitlab_roles
    content {
      access_level = deploy_access_levels.value
    }
  }
}

resource "gitlab_project_protected_environment" "production" {
  count                   = var.create_deployment_environments ? 1 : 0
  project                 = local.project.id
  required_approval_count = local.deploy_access_levels_production.required_approval_count
  environment             = gitlab_project_environment.production[0].name

  dynamic "deploy_access_levels" {
    for_each = local.deploy_access_levels_production.group_ids
    content {
      group_id = deploy_access_levels.value
    }
  }

  dynamic "deploy_access_levels" {
    for_each = local.deploy_access_levels_production.gitlab_roles
    content {
      access_level = deploy_access_levels.value
    }
  }

}
