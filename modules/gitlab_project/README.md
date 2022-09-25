# Terraform module for a Gitlab project
This Terraform module creates a Gitlab project for use at Diehlabs.

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
| [gitlab_project.project](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project) | resource |
| [gitlab_project_badge.project](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_badge) | resource |
| [gitlab_project_environment.all](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_environment) | resource |
| [gitlab_project_share_group.all](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_share_group) | resource |
| [gitlab_project_variable.all](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_variable) | resource |
| [gitlab_group.parent_group](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/data-sources/group) | data source |
| [gitlab_group.share](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | n/a | `any` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | n/a | `any` | n/a | yes |
| <a name="input_environments"></a> [environments](#input\_environments) | n/a | `map` | `{}` | no |
| <a name="input_group_with_project_templates_id"></a> [group\_with\_project\_templates\_id](#input\_group\_with\_project\_templates\_id) | For group-level custom templates, specifies ID of group from which all the custom project templates are sourced. | `any` | `null` | no |
| <a name="input_merge_method"></a> [merge\_method](#input\_merge\_method) | n/a | `any` | n/a | yes |
| <a name="input_merge_pipelines_enabled"></a> [merge\_pipelines\_enabled](#input\_merge\_pipelines\_enabled) | Enable pipelines for merge/pull requests. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_parent_group_name"></a> [parent\_group\_name](#input\_parent\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_project_variables"></a> [project\_variables](#input\_project\_variables) | n/a | `map` | `{}` | no |
| <a name="input_push_rules"></a> [push\_rules](#input\_push\_rules) | n/a | `map` | `{}` | no |
| <a name="input_share_groups"></a> [share\_groups](#input\_share\_groups) | Map of groups to grant access to this project for. | `any` | `{}` | no |
| <a name="input_template_project_id"></a> [template\_project\_id](#input\_template\_project\_id) | Optional template repo to create repo from. | `any` | `null` | no |
| <a name="input_use_custom_template"></a> [use\_custom\_template](#input\_use\_custom\_template) | ----------------------------------------------------------------------------- Following are optional, used when creating a repo based on a template repo. ----------------------------------------------------------------------------- | `bool` | `false` | no |
| <a name="input_visibility_level"></a> [visibility\_level](#input\_visibility\_level) | n/a | `string` | `"private"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_branch"></a> [default\_branch](#output\_default\_branch) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The full path of the repository. |
| <a name="output_namespace_id"></a> [namespace\_id](#output\_namespace\_id) | Namespace ID, i.e. the parent group ID |
| <a name="output_path"></a> [path](#output\_path) | The path of the repository. |
| <a name="output_path_with_namespace"></a> [path\_with\_namespace](#output\_path\_with\_namespace) | The full path of the repository. |
<!-- END_TF_DOCS -->