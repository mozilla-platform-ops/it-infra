locals {
  location_map = {
    "UK South" = "uk-south"
  }
  provisioner = "gecko-t"
  map         = yamldecode(file("../config.yaml"))
  tags = {
    Provisioner = "gecko-t"
    Terraform   = true
  }
}

resource "azurerm_resource_group" "fxci_dev" {
  provider = azurerm.fxci_dev
  for_each = local.location_map
  name     = "rg2-${each.value}-${local.provisioner}"
  location = each.key
}

module "gecko_t_fxci_dev" {
  providers = {
    azurerm = azurerm.fxci_dev
  }
  for_each                            = local.location_map
  source                              = "../../modules/workerPool"
  location                            = each.key
  azurerm_virtual_network_name        = "vn2-${each.value}-${local.provisioner}"
  azurerm_subnet_name                 = "sn2-${each.value}-${local.provisioner}"
  resource_group_name                 = azurerm_resource_group.fxci_dev[each.key].name
  azurerm_network_security_group_name = "nsg2-${each.value}-${local.provisioner}"
  azurerm_public_ip_prefix_name       = "ippre2-${each.value}-${local.provisioner}"
  nat_gateway_name                    = "ng2-${each.value}-${local.provisioner}"
  azurerm_storage_account_name        = "sa2${each.value}-${local.provisioner}"
  vnet_address_space                  = local.map.defaults.vnet_address_space
  vnet_dns_servers                    = local.map.defaults.vnet_dns_servers
  subnet_address_prefixes             = local.map.defaults.subnet_address_prefixes
  provisioner                         = local.provisioner
  tags                                = local.tags
  nsg_security_rules                  = []
  depends_on                          = [azurerm_resource_group.fxci_dev]
}
