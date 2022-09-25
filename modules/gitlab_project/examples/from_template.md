# From template example
* This example uses all default values for inputs where possible, but specifies a repo to use as a template for creating the new repo project.
```hcl
# relies on the environment variable "GITLAB_TOKEN" being set to a valid Gitlab access token
provider "gitlab" {}

module "gitlab_project" {
  source                = "<ssh or https url to module repo>"
  name                  = "microservice-golang-xyz"
  description           = "Repository for the xyz Golang microservice"
  parent_group_name     = "diehlabs/development"
  # the full path to the template project - this can be easily derived from the URL when viewing the project in a browser
  template_project_path = ""diehlabs/development/template-project-golang"
}
```