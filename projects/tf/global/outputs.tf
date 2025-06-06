locals {
  projects_outputs = { for project, config in local.prod_projects_map : project => {
    prod = {
      id                           = module.prod_project[project].project_id
      name                         = module.prod_project[project].name
      number                       = module.prod_project[project].project_number
      zone_name                    = module.prod_dns[project].zone_name
      zone_dns_name                = module.prod_dns[project].zone_dns_name
      repository                   = format("%s-docker.pkg.dev/%s/%s", module.prod_gar[project].repository.location, module.prod_gar[project].repository.project, module.prod_gar[project].repository.repository_id)
      repository_id                = module.prod_gar[project].repository.id
      repository_location          = module.prod_gar[project].repository.location
      repository_project           = module.prod_gar[project].repository.project
      writer_service_account_email = module.prod_gar[project].writer_service_account.email
      writer_service_account_name  = module.prod_gar[project].writer_service_account.name
    },
    nonprod = {
      id                           = config.multirealm ? module.nonprod_project[project].project_id : null
      name                         = config.multirealm ? module.nonprod_project[project].name : null
      number                       = config.multirealm ? module.nonprod_project[project].project_number : null
      zone_name                    = config.multirealm ? module.nonprod_dns[project].zone_name : null
      zone_dns_name                = config.multirealm ? module.nonprod_dns[project].zone_dns_name : null
      repository                   = null
      repository_id                = null
      repository_location          = null
      repository_project           = null
      writer_service_account_email = null
      writer_service_account_name  = null
    },
    folder = {
      id   = config.create_folder ? google_folder.subfolder[project].id : config.parent_id
      name = config.create_folder ? google_folder.subfolder[project].name : config.name
    }
    }
  }
}

output "projects" {
  value = local.projects_outputs
}
