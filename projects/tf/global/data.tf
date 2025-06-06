data "terraform_remote_state" "bootstrap" {
  backend = "gcs"

  config = {
    bucket = "moz-fx-platform-mgmt-global-tf"
    prefix = "projects/bootstrap"
  }
}
