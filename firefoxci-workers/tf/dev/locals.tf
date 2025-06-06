locals {
  application       = "firefoxci-workers"
  risk_level        = "low"
  realm             = "nonprod"
  environment       = "dev"
  network           = module.tenant.network
  project_id        = data.terraform_remote_state.projects.outputs.projects[local.application][local.realm].id
}
