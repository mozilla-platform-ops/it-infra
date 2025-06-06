module "permissions" {
  source                    = "github.com/mozilla/terraform-modules//google_permissions?ref=main"
  google_folder_id          = local.project.folder.id
  google_prod_project_id    = local.project["prod"].id
  google_nonprod_project_id = local.project["nonprod"].id
  admin_ids                 = ["workgroup:firefoxci-workers/admins"]
  developer_ids             = ["workgroup:firefoxci-workers/developers"]
  viewer_ids                = ["workgroup:firefoxci-workers/viewers"]
}
