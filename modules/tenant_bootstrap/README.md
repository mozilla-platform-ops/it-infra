
## Example
```hcl
locals {
  application       = "testapp1"
  risk_level        = "low"
  realm             = "nonprod"
  environment       = "dev"
  github_repository = "mozilla-it/deploy-testapp1"
}

module "tenant" {
  source            = "../../../modules/tenant_bootstrap"
  application       = local.application
  risk_level        = local.risk_level
  realm             = local.realm
  environment       = local.environment
  github_repository = local.github_repository
}
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | The name of the application. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to create (like, 'dev', 'stage', or 'prod') | `string` | n/a | yes |
| <a name="input_function"></a> [function](#input\_function) | The function associated with this application | `string` | `"dataservices"` | no |
| <a name="input_gha_environments"></a> [gha\_environments](#input\_gha\_environments) | A list of Github environments from which the deployment service account can<br>deploy. Specifying a non-default value for this variable will override the<br>"environment" variable in this module.<br><br>We require a manual approval step in the workflow that pushes code to the<br>production environment. You should not leverage this variable to create a<br>production deployment path that bypasses the manual step. An exemption to<br>this rule must be reviewed and documented, preferably in the RRA document of<br>your service. | `list(string)` | `[]` | no |
| <a name="input_github_build_repositories"></a> [github\_build\_repositories](#input\_github\_build\_repositories) | The Github repositories building and uploading images in the format org/repository.<br>Overrides `github_repository` for the artifact-writer service account. | `list(string)` | `[]` | no |
| <a name="input_github_deploy_repositories"></a> [github\_deploy\_repositories](#input\_github\_deploy\_repositories) | The Github repositories deploying helm charts in the format org/repository.<br>Overrides `github_repository` for the deploy service account. | `list(string)` | `[]` | no |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | The Github repository building the image and running the deployment workflows in the format<br>org/repository. Can be overridden by `github_build_repositories` and `github_deploy_repositories`,<br>which take precendence over this variable if provided. | `string` | `null` | no |
| <a name="input_github_require_build_env"></a> [github\_require\_build\_env](#input\_github\_require\_build\_env) | Whether to require GitHub Actions jobs to use an environment called "build" to be<br>able to get access to the artifact-writer service account and push Docker images. | `bool` | `true` | no |
| <a name="input_log_analytics"></a> [log\_analytics](#input\_log\_analytics) | Enable log analytics for log bucket | `bool` | `false` | no |
| <a name="input_log_destination"></a> [log\_destination](#input\_log\_destination) | The destination for tenant logs, defaults to bucket. Valid options are "bucket" and "bigquery" | `string` | `"bucket"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID in which we're doing this work. | `string` | `null` | no |
| <a name="input_realm"></a> [realm](#input\_realm) | Name of infrastructure realm (e.g. prod, nonprod, mgmt, or global). | `string` | n/a | yes |
| <a name="input_risk_level"></a> [risk\_level](#input\_risk\_level) | Risk level associated with application | `string` | n/a | yes |
| <a name="input_wip_name"></a> [wip\_name](#input\_wip\_name) | The name of the workload identity provider | `string` | `"github-actions"` | no |
| <a name="input_wip_project_number"></a> [wip\_project\_number](#input\_wip\_project\_number) | The project number of the project the workload identity provider lives in | `number` | `324168772199` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_deploy_service_account_email"></a> [deploy\_service\_account\_email](#output\_deploy\_service\_account\_email) | n/a |
| <a name="output_deploy_service_account_name"></a> [deploy\_service\_account\_name](#output\_deploy\_service\_account\_name) | n/a |
| <a name="output_gke_service_account_email"></a> [gke\_service\_account\_email](#output\_gke\_service\_account\_email) | n/a |
| <a name="output_gke_service_account_name"></a> [gke\_service\_account\_name](#output\_gke\_service\_account\_name) | n/a |
| <a name="output_logging_bucket_id"></a> [logging\_bucket\_id](#output\_logging\_bucket\_id) | n/a |
| <a name="output_network"></a> [network](#output\_network) | n/a |
| <a name="output_public_ips"></a> [public\_ips](#output\_public\_ips) | n/a |
