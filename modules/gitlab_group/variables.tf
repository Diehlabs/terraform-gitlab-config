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
  #   "verituity/devops" = "maintainer"
  #   # full_path = group_access
  # }
}
