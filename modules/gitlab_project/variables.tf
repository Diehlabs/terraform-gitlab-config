variable "name" {}

variable "description" {}

variable "visibility_level" {
  default = "private"
}

# variable "namespace" {
#   type = string
#   description = "The namespace/path (group or user) of the project."
# }

variable "parent_group_name" {}

variable "default_branch" {
  default = "main"
}

variable "merge_method" {
  default = "merge"
}

variable "push_rules" {
  default = {}
}

variable "environments" {
  default = {}
}

variable "share_groups" {
  default     = {}
  type        = any
  description = "Map of groups to grant access to this project for."
  # {
  #   "verituity/devops" = "maintainer"
  #   * full_path = group_access
  # }
}

variable "merge_pipelines_enabled" {
  type        = bool
  description = "Enable pipelines for merge/pull requests."
  default     = true
}

# -----------------------------------------------------------------------------
# Following are optional, used when creating a repo based on a template repo.
# -----------------------------------------------------------------------------
# variable "template_repo" {
# description = "Specify the Gitlab group and child project to use as a template for this project."
# type = object({
#   group_path   = string
#   project_name = string
# })
# default = {}
variable "template_project_path" {
  description = "The full path of the project to use as a template for this project"
  default     = null
}

variable "project_variables" {
  default = {}
  /*
  name = {
    value = string * required
    protected bool *optional, false
    masked *optional, true
    environment_scope *optional, "*"
*/
}

variable "init_with_readme" {
  description = "Whether or not to initialize reop with a generic readme. May conflict with push rules."
  default     = false
}

variable "disable_overriding_approvers_per_merge_request" {
  description = "Whether to allow overriding approvers per merge request"
  type        = bool
  default     = true
}

variable "create_init_file" {
  description = "Whether to create an initial file in the repo so that main branch exists"
  type        = bool
  default     = true
}

variable "pipeline_schedules" {
  description = "Object defining one or more schedules to configure for the project pipeline"
  default     = {}
  # example:
  # {
  #   main_sched = {
  #     description = "Used to schedule builds"
  #     ref         = "master"
  #     cron        = "0 1 * * *"
  #   }
  # }
}

variable "wiki_enabled" {
  default = false
}
variable "request_access_enabled" {
  default = false
}
variable "packages_enabled" {
  default = false
}
variable "container_registry_enabled" {
  default = false
}

variable "import_url" {
  description = "Git URL to a repository to be imported."
  default     = ""
}

variable "mirror" {
  description = "Enable project pull mirror."
  default     = false
}

variable "external_wiki_url" {
  description = "Allows to manage the lifecycle of a project integration with External Wiki Service"
  type        = string
  default     = null
}