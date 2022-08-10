locals {
  external_wiki_url = try(var.external_wiki_url, null) == null ? {} : { url = var.external_wiki_url }
}

resource "gitlab_service_external_wiki" "wiki" {
  for_each          = local.external_wiki_url
  project           = local.project.id
  external_wiki_url = each.value
}