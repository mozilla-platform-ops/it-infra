locals {
  application = "firefoxci-workers"
  project     = data.terraform_remote_state.projects.outputs.projects[local.application]
}
