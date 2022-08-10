variable "groups" {
  description = "A map of groups to create."
  default     = {}
}

variable "projects" {
  description = "A map of projects to create."
  default     = {}
}

variable "defaults" {
  description = "Defaults to be applied to all applicable resources. If a different setting is not specified for each resource, the value(s) here will be used."
}