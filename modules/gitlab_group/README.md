<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | 3.15.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [gitlab_group.group](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group) | resource |
| [gitlab_group_share_group.all](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group_share_group) | resource |
| [gitlab_group.parent_group](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/data-sources/group) | data source |
| [gitlab_group.share](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | n/a | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_parent_group_name"></a> [parent\_group\_name](#input\_parent\_group\_name) | n/a | `any` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | n/a | `any` | `null` | no |
| <a name="input_request_access_enabled"></a> [request\_access\_enabled](#input\_request\_access\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_share_groups"></a> [share\_groups](#input\_share\_groups) | Map of groups to grant access to this group for. | `any` | `{}` | no |
| <a name="input_visibility_level"></a> [visibility\_level](#input\_visibility\_level) | n/a | `string` | `"private"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_full_name"></a> [full\_name](#output\_full\_name) | n/a |
| <a name="output_full_path"></a> [full\_path](#output\_full\_path) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_parent_id"></a> [parent\_id](#output\_parent\_id) | n/a |
| <a name="output_path"></a> [path](#output\_path) | n/a |
| <a name="output_runners_token"></a> [runners\_token](#output\_runners\_token) | n/a |
<!-- END_TF_DOCS -->