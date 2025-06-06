provider "google" {
  impersonate_service_account = "tf-it@moz-fx-it-terraform-admin.iam.gserviceaccount.com"
  region                      = "us-west1"
}

provider "google-beta" {
  impersonate_service_account = "tf-it@moz-fx-it-terraform-admin.iam.gserviceaccount.com"
  region                      = "us-west1"
}
