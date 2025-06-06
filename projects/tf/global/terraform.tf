terraform {
  backend "gcs" {
    bucket                      = "moz-fx-it-terraform-state-global"
    prefix                      = "projects/projects/global"
    impersonate_service_account = "tf-it@moz-fx-it-terraform-admin.iam.gserviceaccount.com"
  }
}
