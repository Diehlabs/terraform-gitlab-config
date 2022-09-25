variable "name" {}

variable "path" {
  default = null
}

variable "description" {}

variable "request_access_enabled" {
  default = true
}

variable "visibility_level" {
  default = "private"
}

variable "parent_group_name" {
  default = null
}

variable "share_groups" {
  default     = {}
  type        = any
  description = "Map of groups to grant access to this group for."
  # share_groups = {
  #   "diehlabs/devops" = "maintainer"
  #   # full_path = group_access
  # }
}

# variable "create_group_access_token" {
#   description = "If set to true will create a GAT and add it as a CICD variable named GA_TOKEN on the managed group. This would be used with CICD."
#   type        = bool
#   default     = false
# }

# variable "gitlab_group_access_token_scopes" {
#   description = "Scopes to be used for the group access token. Only used if create_group_access_token is set to true."
#   type        = list(string)
#   default = [
#     "read_api",
#     "read_repository",
#   ]
#   # add constraints here to ensure only acceptable values are passed..
# }
