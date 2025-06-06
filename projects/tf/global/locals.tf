locals {
  applications = data.terraform_remote_state.bootstrap.outputs.folders["it/applications"]
  internal     = data.terraform_remote_state.bootstrap.outputs.folders["it/internal"]
  management   = data.terraform_remote_state.bootstrap.outputs.folders["it/management"]
  region       = "us-west1"
  team         = "it"

  parent_dns = {
    "nonprod" = {
      "zone_name"  = data.terraform_remote_state.bootstrap.outputs.dns_zones["nonprod.it.mozgcp.net/zone_name"],
      "project_id" = data.terraform_remote_state.bootstrap.outputs.dns_zones["nonprod.it.mozgcp.net/project_id"]
    },
    "prod" = {
      "zone_name"  = data.terraform_remote_state.bootstrap.outputs.dns_zones["prod.it.mozgcp.net/zone_name"],
      "project_id" = data.terraform_remote_state.bootstrap.outputs.dns_zones["prod.it.mozgcp.net/project_id"]
    }
  }

  defaults = {
    billing_id       = data.terraform_remote_state.bootstrap.outputs.billing_account_ids["default"]
    create_folder    = true
    parent_id        = local.applications
    project_services = ["secretmanager.googleapis.com"]
    multirealm       = true
    random_id        = false
    risk_level       = "high"
    log_analytics    = true // Enable logging for _Default log bucket 
  }

  projects = [
    # {
    #   name       = "absearch"
    #   app_code   = "absearch"
    #   risk_level = "high"
    # },
  ]

  nonprod_projects_map = {
    for project in local.projects : project.name => merge(local.defaults, project) if lookup(project, "multirealm", local.defaults.multirealm)
  }

  prod_projects_map = {
    for project in local.projects : project.name => merge(local.defaults, project)
  }

  folders_map = {
    for project in local.projects : project.name => merge(local.defaults, project) if lookup(project, "create_folder", local.defaults.create_folder)
  }
}
