output "id" {
  value = gitlab_group.group.id
}

output "parent_id" {
  value = gitlab_group.group.parent_id
}

output "path" {
  value = gitlab_group.group.path
}

output "full_path" {
  value = gitlab_group.group.full_path
}

output "full_name" {
  value = gitlab_group.group.full_name
}

output "runners_token" {
  value     = gitlab_group.group.runners_token
  sensitive = true
}

output "group_obj" {
  description = "The entire group object that was created."
  value       = gitlab_group.group
}