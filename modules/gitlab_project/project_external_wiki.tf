# -----------------------------------------------------------------------------
# Create the external wiki link if var.external_wiki_url is not null(default)
# -----------------------------------------------------------------------------
resource "gitlab_service_external_wiki" "wiki" {
  count             = var.external_wiki_url == null ? 0 : 1
  project           = local.project.id
  external_wiki_url = var.external_wiki_url
}