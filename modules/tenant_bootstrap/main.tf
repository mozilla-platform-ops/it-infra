module "google_gke_tenant" {
  source = "github.com/mozilla/terraform-modules//google_gke_tenant?ref=google_gke_tenant-1.0.0"

  application        = var.application
  cluster_project_id = local.gke_cluster_project_id
  environment        = var.environment
  project_id         = var.project_id
}

module "google_deployment_accounts" {
  count  = length(compact(local.github_deploy_repositories)) > 0 ? 1 : 0
  source = "github.com/mozilla/terraform-modules//google_deployment_accounts?ref=v2.6.1"

  project             = var.project_id
  environment         = var.environment
  gha_environments    = var.gha_environments
  github_repositories = local.github_deploy_repositories
  wip_name            = var.wip_name
  wip_project_number  = var.wip_project_number
}

# Adding moved block to accomodate new count in module.google_deployment_accounts
moved {
  from = module.google_deployment_accounts
  to   = module.google_deployment_accounts[0]
}

module "gke_logging" {
  source = "github.com/mozilla/terraform-modules//google_gke_namespace_logging?ref=v2.6.1"

  application                           = var.application
  environment                           = var.environment
  project                               = var.project_id
  log_destination                       = var.log_destination
  logging_writer_service_account_member = local.logging_writer_service_account_member
  log_analytics                         = var.log_analytics
  retention_days                        = var.log_retention_days
}

resource "google_service_account_iam_binding" "artifact_writer_access" {
  count              = length(local.build_principals) >= 1 ? 1 : 0
  service_account_id = local.writer_service_account_name
  role               = "roles/iam.workloadIdentityUser"
  members            = local.build_principals
}
