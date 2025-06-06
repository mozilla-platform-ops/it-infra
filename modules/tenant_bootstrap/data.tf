data "terraform_remote_state" "platform_shared" {
  backend = "gcs"

  config = {
    bucket                      = "moz-fx-platform-terraform-state-global"
    prefix                      = "projects/platform-shared/global"
    impersonate_service_account = "tf-dataservices@moz-fx-datasvc-terraform-admin.iam.gserviceaccount.com"
  }
}

data "terraform_remote_state" "gke" {
  backend = "gcs"

  config = {
    bucket                      = "moz-fx-platform-terraform-state-global"
    prefix                      = "projects/${local.cluster}/${var.realm}"
    impersonate_service_account = "tf-dataservices@moz-fx-datasvc-terraform-admin.iam.gserviceaccount.com"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket                      = "moz-fx-platform-mgmt-global-tf"
    prefix                      = "projects/functional-org-vpc"
    impersonate_service_account = "tf-dataservices@moz-fx-datasvc-terraform-admin.iam.gserviceaccount.com"
  }
}

data "terraform_remote_state" "projects" {
  backend = "gcs"

  config = {
    bucket                      = "moz-fx-dataservices-terraform-state-global"
    prefix                      = "projects/projects/global"
    impersonate_service_account = "tf-dataservices@moz-fx-datasvc-terraform-admin.iam.gserviceaccount.com"
  }
}
