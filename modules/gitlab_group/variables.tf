variable "name" {}

variable "path" {
  description = "(Optional) the path to be used in the URL. Use if other than the group name is desired."
  type        = string
  default     = null
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
  #   "verituity/devops" = "maintainer"
  #   # full_path = group_access
  # }
}

variable "create_group_access_token" {
  description = "If set to true will create a GAT and add it as a CICD variable named GA_TOKEN on the managed group. This would be used with CICD."
  type        = bool
  default     = false
}

# variable "gitlab_group_access_token_scopes" {
#   description = "Scopes to be used for the group access token. Only used if create_group_access_token is set to true."
#   type        = list(string)
#   default = [
#     "read_api",
#     "read_repository",
#   ]
#   # add constraints here to ensure only acceptable values are passed..
# }

variable "access_tokens" {
  type = map(any)
}

variable "saml_links" {
  description = "A map of SAML group names and access levels to use for this Gitlab group."
  type        = map(any)
  default     = {}
}

variable "group_variables" {
  default     = {}
  description = <<EOT
A map of variables to create for this project. Ex:
my_var_1 = {
  value = string * required
  protected bool *optional, false
  masked *optional, true
  environment_scope *optional, "*"
}
EOT
}
