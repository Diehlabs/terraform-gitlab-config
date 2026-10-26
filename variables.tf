variable "groups" {
  description = "A map of groups to create."
  # Values are heterogeneous objects read via try() with fallbacks; see main.tf
  type    = any
  default = {}
}

variable "projects" {
  description = "A map of projects to create."
  # Values are heterogeneous objects read via try() with fallbacks; see main.tf
  type    = any
  default = {}
}

variable "defaults" {
  description = "Defaults to be applied to all applicable resources. If a different setting is not specified for each resource, the value(s) here will be used."
  type        = any
}