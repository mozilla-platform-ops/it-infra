resource "google_folder" "subfolder" {
  for_each = local.folders_map

  display_name = each.value.name
  parent       = each.value.parent_id
}

module "prod_project" {
  source   = "github.com/mozilla/terraform-modules//google_project?ref=v2.6.0"
  for_each = local.prod_projects_map

  project_name = each.value.name
  display_name = length(lookup(each.value, "display_name", "")) > 0 ? "${substr(each.value.display_name, 0, 25)}-prod" : null
  project_id   = each.value.random_id ? null : substr("moz-fx-${each.value.name}-prod", 0, 30)

  billing_account_id = each.value.billing_id
  parent_id          = each.value.create_folder ? google_folder.subfolder[each.value.name].id : each.value.parent_id
  app_code           = each.value.app_code
  project_services   = each.value.project_services
  risk_level         = each.value.risk_level
  realm              = "prod"
  log_analytics      = each.value.log_analytics
}

module "nonprod_project" {
  source   = "github.com/mozilla/terraform-modules//google_project?ref=v2.6.0"
  for_each = local.nonprod_projects_map

  project_name = each.value.name
  display_name = length(lookup(each.value, "display_name", "")) > 0 ? "${substr(each.value.display_name, 0, 22)}-nonprod" : null
  project_id   = each.value.random_id ? null : substr("moz-fx-${each.value.name}-nonprod", 0, 30)

  billing_account_id = each.value.billing_id
  parent_id          = each.value.create_folder ? google_folder.subfolder[each.value.name].id : each.value.parent_id
  app_code           = each.value.app_code
  project_services   = each.value.project_services
  risk_level         = each.value.risk_level
  realm              = "nonprod"
  log_analytics      = each.value.log_analytics
}
