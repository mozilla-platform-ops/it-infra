terraform {
  backend "azurerm" {
    resource_group_name  = "it-infra-terraform-state"
    storage_account_name = "mozitinfratfstate"
    container_name       = "taskcluster"
    key                  = "gecko-t.terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  #alias           = "fxci"
  subscription_id = "108d46d5-fe9b-4850-9a7d-8c914aa6c1f0"
}

provider "azurerm" {
  features {}
  alias           = "trusted"
  subscription_id = "a30e97ab-734a-4f3b-a0e4-c51c0bff0701"
}

provider "azurerm" {
  features {}
  alias           = "fxci_dev"
  subscription_id = "0a420ff9-bc77-4475-befc-a05071fc92ec"
}

provider "azurerm" {
  features {}
  alias           = "taskcluster"
  subscription_id = "8a205152-b25a-417f-a676-80465535a6c9"
}

provider "azuread" {
  tenant_id = "c0dc8bb0-b616-427e-8217-9513964a145b"
}
