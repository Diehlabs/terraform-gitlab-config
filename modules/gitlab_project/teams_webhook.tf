resource "gitlab_service_microsoft_teams" "teams" {
  # if var.teams_settings.webhook_url is there, create the resource
  count                        = try(var.teams_settings.webhook, false) != false ? 1 : 0
  project                      = local.project.id
  webhook                      = var.teams_settings.webhook
  push_events                  = var.teams_settings.push_events
  tag_push_events              = var.teams_settings.tag_push_events
  notify_only_broken_pipelines = var.teams_settings.notify_only_broken_pipelines
  merge_requests_events        = var.teams_settings.merge_requests_events
  wiki_page_events             = var.teams_settings.wiki_page_events
  branches_to_be_notified      = var.teams_settings.branches_to_be_notified
}