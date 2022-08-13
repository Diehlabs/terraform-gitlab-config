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
  description = "Enable pipelines for merge/pull requests."
  type        = bool
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
  type        = bool
  default     = false
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
  type    = bool
  default = false
}
variable "request_access_enabled" {
  type    = bool
  default = false
}
variable "packages_enabled" {
  type    = bool
  default = false
}
variable "container_registry_enabled" {
  type    = bool
  default = false
}

variable "import_url" {
  description = "Git URL to a repository to be imported."
  # Default must be a blank string, "null" causes errors.
  default = ""
}

variable "mirror" {
  description = "Enable project pull mirror."
  type        = bool
  default     = false
}

variable "external_wiki_url" {
  description = "Allows to manage the lifecycle of a project integration with External Wiki Service"
  type        = string
  default     = null
}

variable "pipelines_enabled" {
  description = "Pipelines enabled on this project"
  type        = bool
  default     = true
}

variable "lfs_enabled" {
  description = "Git large filesystem enabled"
  type        = bool
  default     = false
}

variable "issues_enabled" {
  description = "Issues enabled"
  type        = bool
  default     = false
}

variable "remove_source_branch_after_merge" {
  description = "Remove the source branch after completed merge"
  type        = bool
  default     = true
}

variable "only_allow_merge_if_pipeline_succeeds" {
  description = "Only allow merge if merge pipeline succeeds"
  type        = bool
  default     = true
}

variable "shared_runners_enabled" {
  description = "Allow pipelines to run on shared runners"
  type        = bool
  default     = true
}

variable "merge_request_approval_settings" {
  description = "Settings for merge request approvals on the project"
  type = object({
    reset_approvals_on_push                        = bool
    disable_overriding_approvers_per_merge_request = bool
    merge_requests_author_approval                 = bool
    merge_requests_disable_committers_approval     = bool
  })
}

variable "public_builds" {
  description = "If true, jobs can be viewed by non-project members."
  type        = bool
  default     = false
}