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
