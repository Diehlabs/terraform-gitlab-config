# -----------------------------------------------------------------------------
# # optionally schedule the pipeline, like for letsencrypt tf repos
# https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/pipeline_schedule
# -----------------------------------------------------------------------------
resource "gitlab_pipeline_schedule" "all" {
  for_each    = var.pipeline_schedules
  project     = local.project.id
  description = each.value.description
  ref         = each.value.ref
  cron        = each.value.cron
}