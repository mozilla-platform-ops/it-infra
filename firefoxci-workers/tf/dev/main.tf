module "tenant" {
  source            = "../../../modules/tenant_bootstrap"
  application       = local.application
  risk_level        = local.risk_level
  realm             = local.realm
  environment       = local.environment
  project_id        = local.project_id
}
