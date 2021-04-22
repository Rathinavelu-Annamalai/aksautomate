terraform {
  required_version = ">= 0.12.0"
}
provider "azurerm" {
features {}
subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Cluster Resource Group

resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location
  tags = var.tags
}
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  admin_enabled       = false
  sku                 = "Premium"
}
# AKS Cluster Network

/*provider "azuread" {
  version = "~>0.7"
}

data "azuread_service_principal" "aks_principal" {
  application_id = var.client_id
}*/
/*resource "azurerm_role_assignment" "acrpull_role" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = var.client_id
  skip_service_principal_aad_check = true
}
*/
module "aks_network" {
  source              = "../modules/aks_network"
  subnet_name         = var.subnet_name
  vnet_name           = var.vnet_name
  resource_group_name = azurerm_resource_group.aks.name
  subnet_cidr         = var.subnet_cidr
  location            = var.location
  address_space       = var.address_space
}

# AKS IDs
/*
module "aks_identities" {
  source       = "../modules/aks_identities"
  cluster_name = var.cluster_name
  //client_id                = module.aks_identities.cluster_client_id
  //client_secret            = module.aks_identities.cluster_sp_secret
}*/

# AKS Log Analytics

module "log_analytics" {
  source                           = "../modules/log_analytics"
  resource_group_name              = azurerm_resource_group.aks.name
  log_analytics_workspace_location = var.log_analytics_workspace_location
  log_analytics_workspace_name     = var.log_analytics_workspace_name
  log_analytics_workspace_sku      = var.log_analytics_workspace_sku
}


# AKS Cluster

module "aks_cluster" {
  source                   = "../modules/aks-cluster"
  cluster_name             = var.cluster_name
  location                 = var.location
  dns_prefix               = var.dns_prefix
  resource_group_name      = azurerm_resource_group.aks.name
  //kubernetes_version       = var.kubernetes_version
  node_count               = var.node_count
  min_count                = var.min_count
  max_count                = var.max_count
  os_disk_size_gb          = "1028"
  max_pods                 = "110"
  vm_size                  = var.vm_size
  vnet_subnet_id           = module.aks_network.aks_subnet_id
  client_id                = var.client_id
  client_secret            = var.client_secret
  diagnostics_workspace_id = module.log_analytics.azurerm_log_analytics_workspace
}


resource "kubernetes_namespace" "example" {
  metadata {
    annotations = {
      name = "assetmanager-api"
    }

    labels = {
      mylabel = "assetmanager-api"
    }

    name = "ingress-basic"
  }
}




