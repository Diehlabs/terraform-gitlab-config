variable "gitlab_group_access_token_scopes" {
  description = "Scopes to be used for the group access token. Only used if create_group_access_token is set to true."
  type        = list(string)
  default = [
    "read_api",
    "read_repository",
  ]
  # add constraints here to ensure only acceptable values are passed..
}

variable "group_id" {
  description = "ID of the group to create a group access token for. A group variable will also be created that contains the token unless var.project_id is also specified."
}

variable "project_id" {
  description = "A project variable will be created that contains the token rather than using a group variable if not set to null."
  default     = null
}