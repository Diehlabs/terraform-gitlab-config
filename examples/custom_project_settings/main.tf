provider "gitlab" {}

module "gitlab_config" {
  source   = "../.."
  groups   = local.groups
  projects = local.projects
  defaults = local.defaults
}
