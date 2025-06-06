output "logging_bucket_id" {
  value = module.gke_logging.logging_bucket_id
}

output "logging_dataset_id" {
  value = module.gke_logging.logging_dataset_id
}

output "gke_service_account_email" {
  value = module.google_gke_tenant.gke_service_account.email
}

output "gke_service_account_name" {
  value = module.google_gke_tenant.gke_service_account.name
}

output "deploy_service_account_email" {
  value = try(module.google_deployment_accounts[0].service_account.email, "")
}

output "deploy_service_account_name" {
  value = try(module.google_deployment_accounts[0].service_account.name, "")
}

output "network" {
  value = data.terraform_remote_state.vpc.outputs.networks.realm[var.realm]
}

output "public_ips" {
  value = local.public_ips
}

output "internal_ips" {
  value = local.internal_ips
}
