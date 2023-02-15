# Basic example
* This example uses all default values for inputs where possible.
```hcl
# relies on the environment variable "GITLAB_TOKEN" being set to a valid Gitlab access token
provider "gitlab" {}

module "gitlab_project" {
  source            = "<ssh or https url to module repo>"
  name              = "microservice-golang-xyz"
  description       = "Repository for the xyz Golang microservice"
  parent_group_name = "diehlabs/development"
}
```