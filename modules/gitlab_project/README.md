# Terraform module for a Gitlab project
This Terraform module creates a Gitlab project for use at Verituity.

## Examples
* [Basic](docs/examples/basic.md)
* [Advanced](docs/examples/advanced.md)
* [Use a project as a template](docs/examples/from_template.md)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [gitlab_deploy_token.default](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/deploy_token) | resource |
| [gitlab_pipeline_schedule.all](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/pipeline_schedule) | resource |
| [gitlab_project.empty](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project) | resource |
| [gitlab_project.from_template](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project) | resource |
| [gitlab_project_approval_rule.default](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_approval_rule) | resource |
| [gitlab_project_badge.project](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_badge) | resource |
| [gitlab_project_environment.development](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_environment) | resource |
| [gitlab_project_environment.production](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_environment) | resource |
| [gitlab_project_environment.staging](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_environment) | resource |
| [gitlab_project_level_mr_approvals.mra](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_level_mr_approvals) | resource |
| [gitlab_project_protected_environment.development](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_protected_environment) | resource |
| [gitlab_project_protected_environment.production](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_protected_environment) | resource |
| [gitlab_project_protected_environment.staging](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_protected_environment) | resource |
| [gitlab_project_variable.all](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_variable) | resource |
| [gitlab_project_variable.gitlab_deploy_token](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_variable) | resource |
| [gitlab_project_variable.gitlab_deploy_token_user](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_variable) | resource |
| [gitlab_service_external_wiki.wiki](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/service_external_wiki) | resource |
| [gitlab_service_microsoft_teams.teams](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/service_microsoft_teams) | resource |
| [gitlab_project.template_project](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_approval_rule"></a> [approval\_rule](#input\_approval\_rule) | Approval rule definition. Map of the following properties:<br>name               = string<br>approvals\_required = number<br>user\_ids           = list(string)<br>group\_ids          = list(string) | `any` | n/a | yes |
| <a name="input_container_registry_enabled"></a> [container\_registry\_enabled](#input\_container\_registry\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_create_deploy_token"></a> [create\_deploy\_token](#input\_create\_deploy\_token) | Will create a project scoped deploy token and stored it as PROJECT\_DEPLOY\_TOKEN as a CICD variable on the project. | `bool` | `false` | no |
| <a name="input_create_deployment_environments"></a> [create\_deployment\_environments](#input\_create\_deployment\_environments) | Whether to create standard environments and approval settings. | `bool` | n/a | yes |
| <a name="input_create_init_file"></a> [create\_init\_file](#input\_create\_init\_file) | Whether to create an initial file in the repo so that main branch exists | `bool` | `true` | no |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | n/a | `string` | `"main"` | no |
| <a name="input_deploy_access_levels_development"></a> [deploy\_access\_levels\_development](#input\_deploy\_access\_levels\_development) | Map of group\_ids and Gitlab roles that should be able to approve deployments. | `any` | n/a | yes |
| <a name="input_deploy_access_levels_production"></a> [deploy\_access\_levels\_production](#input\_deploy\_access\_levels\_production) | Map of group\_ids and Gitlab roles that should be able to approve deployments. | `any` | n/a | yes |
| <a name="input_deploy_access_levels_staging"></a> [deploy\_access\_levels\_staging](#input\_deploy\_access\_levels\_staging) | Map of group\_ids and Gitlab roles that should be able to approve deployments. | `any` | n/a | yes |
| <a name="input_deploy_token_scopes"></a> [deploy\_token\_scopes](#input\_deploy\_token\_scopes) | Defines the rights for the optional deploy token. Only evaluated if create\_deploy\_token is set to true. | `list(string)` | `[]` | no |
| <a name="input_deployment_environments_non_prod"></a> [deployment\_environments\_non\_prod](#input\_deployment\_environments\_non\_prod) | n/a | `list` | `[]` | no |
| <a name="input_deployment_environments_production"></a> [deployment\_environments\_production](#input\_deployment\_environments\_production) | n/a | `list` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | n/a | `any` | n/a | yes |
| <a name="input_external_wiki_url"></a> [external\_wiki\_url](#input\_external\_wiki\_url) | Allows to manage the lifecycle of a project integration with External Wiki Service | `string` | `null` | no |
| <a name="input_import_url"></a> [import\_url](#input\_import\_url) | Git URL to a repository to be imported. | `string` | `""` | no |
| <a name="input_init_with_readme"></a> [init\_with\_readme](#input\_init\_with\_readme) | Whether or not to initialize reop with a generic readme. May conflict with push rules. | `bool` | `false` | no |
| <a name="input_issues_enabled"></a> [issues\_enabled](#input\_issues\_enabled) | Issues enabled | `bool` | `false` | no |
| <a name="input_lfs_enabled"></a> [lfs\_enabled](#input\_lfs\_enabled) | Git large filesystem enabled | `bool` | `false` | no |
| <a name="input_merge_method"></a> [merge\_method](#input\_merge\_method) | n/a | `string` | `"merge"` | no |
| <a name="input_merge_pipelines_enabled"></a> [merge\_pipelines\_enabled](#input\_merge\_pipelines\_enabled) | Enable pipelines for merge/pull requests. | `bool` | n/a | yes |
| <a name="input_merge_request_approval_settings"></a> [merge\_request\_approval\_settings](#input\_merge\_request\_approval\_settings) | Settings for merge request approvals on the project | `map(any)` | n/a | yes |
| <a name="input_merge_trains_enabled"></a> [merge\_trains\_enabled](#input\_merge\_trains\_enabled) | Enable or disabled merge trains. | `bool` | `false` | no |
| <a name="input_mirror"></a> [mirror](#input\_mirror) | Enable project pull mirror. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_only_allow_merge_if_pipeline_succeeds"></a> [only\_allow\_merge\_if\_pipeline\_succeeds](#input\_only\_allow\_merge\_if\_pipeline\_succeeds) | Only allow merge if merge pipeline succeeds | `bool` | n/a | yes |
| <a name="input_packages_enabled"></a> [packages\_enabled](#input\_packages\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_parent_group_id"></a> [parent\_group\_id](#input\_parent\_group\_id) | variable "parent\_group\_name" {} | `any` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Short path for the project. Usually the same as the name but without spaces. | `any` | n/a | yes |
| <a name="input_pipeline_schedules"></a> [pipeline\_schedules](#input\_pipeline\_schedules) | Object defining one or more schedules to configure for the project pipeline | `map` | `{}` | no |
| <a name="input_pipelines_enabled"></a> [pipelines\_enabled](#input\_pipelines\_enabled) | Pipelines enabled on this project | `bool` | `true` | no |
| <a name="input_project_variables"></a> [project\_variables](#input\_project\_variables) | n/a | `map` | `{}` | no |
| <a name="input_public_builds"></a> [public\_builds](#input\_public\_builds) | If true, jobs can be viewed by non-project members. | `bool` | `false` | no |
| <a name="input_push_rules"></a> [push\_rules](#input\_push\_rules) | n/a | `map` | `{}` | no |
| <a name="input_remove_source_branch_after_merge"></a> [remove\_source\_branch\_after\_merge](#input\_remove\_source\_branch\_after\_merge) | Remove the source branch after completed merge | `bool` | `true` | no |
| <a name="input_request_access_enabled"></a> [request\_access\_enabled](#input\_request\_access\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_share_groups"></a> [share\_groups](#input\_share\_groups) | Map of groups to grant access to this project for. | `any` | `{}` | no |
| <a name="input_shared_runners_enabled"></a> [shared\_runners\_enabled](#input\_shared\_runners\_enabled) | Allow pipelines to run on shared runners | `bool` | `true` | no |
| <a name="input_squash_option"></a> [squash\_option](#input\_squash\_option) | Squash commits when merge request. Valid values are never, always, default\_on, or default\_off. | `string` | `"default_on"` | no |
| <a name="input_teams_settings"></a> [teams\_settings](#input\_teams\_settings) | MS Teams integration settings. | `any` | n/a | yes |
| <a name="input_template_project_path"></a> [template\_project\_path](#input\_template\_project\_path) | The full path of the project to use as a template for this project | `any` | `null` | no |
| <a name="input_visibility_level"></a> [visibility\_level](#input\_visibility\_level) | n/a | `string` | `"private"` | no |
| <a name="input_wiki_enabled"></a> [wiki\_enabled](#input\_wiki\_enabled) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_create_deploy_token"></a> [create\_deploy\_token](#output\_create\_deploy\_token) | A deploy token scoped to this project. |
| <a name="output_create_deploy_token_username"></a> [create\_deploy\_token\_username](#output\_create\_deploy\_token\_username) | The name token scoped to this project. |
| <a name="output_default_branch"></a> [default\_branch](#output\_default\_branch) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace of the repository. |
| <a name="output_path"></a> [path](#output\_path) | The path of the repository. |
| <a name="output_path_with_namespace"></a> [path\_with\_namespace](#output\_path\_with\_namespace) | The full path of the repository. |
| <a name="output_project_obj"></a> [project\_obj](#output\_project\_obj) | The entire project object that was created. |
<!-- END_TF_DOCS -->