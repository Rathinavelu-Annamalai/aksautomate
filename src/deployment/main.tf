terraform {
  required_version = ">= 0.12.0"
}
provider "azurerm" {
features {}
}

# Cluster Resource Group

resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location
  tags = var.tags
}

# AKS Cluster Network

module "aks_network" {
  source              = "../modules/aks_network"
  subnet_name         = var.subnet_name
  vnet_name           = var.vnet_name
  resource_group_name = azurerm_resource_group.aks.name
  subnet_cidr         = var.subnet_cidr
  location            = var.location
  address_space       = var.address_space
}

resource "azurerm_user_assigned_identity" "aksIdentity" {
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location

  name = "dev4-runincloud"

 tags = {
    ModeOfDeployment = var.modeofdeployment
    CreatedBy = var.createdby
    Environment = var.tag_name
   }
}
# AKS IDs
/*
module "aks_identities" {
  source       = "../modules/aks_identities"
  cluster_name = var.cluster_name
  //client_id                = module.aks_identities.cluster_client_id
  //client_secret            = module.aks_identities.cluster_sp_secret
}
*/
# AKS Log Analytics

module "log_analytics" {
  source                           = "../modules/log_analytics"
  resource_group_name              = azurerm_resource_group.aks.name
  log_analytics_workspace_location = var.log_analytics_workspace_location
  log_analytics_workspace_name     = var.log_analytics_workspace_name
  log_analytics_workspace_sku      = var.log_analytics_workspace_sku
}


# AKS Cluster


resource "azurerm_kubernetes_cluster" "k8s" {
  name       = var.aks_name
  location   = azurerm_resource_group.aks.location
  dns_prefix = var.aks_dns_prefix
  kubernetes_version = var.kubernetes_version
  resource_group_name = azurerm_resource_group.rg_AG.name
/*
  linux_profile {
    admin_username = var.vm_user_name

    ssh_key {
      key_data = file(var.public_ssh_key_path)
    }
  }
*/
  addon_profile {
    http_application_routing {
      enabled = false
    }
  }

  default_node_pool {
    name            = "agentpool"
    node_count      = var.aks_agent_count
    vm_size         = var.aks_agent_vm_size
    os_disk_size_gb = var.aks_agent_os_disk_size
    vnet_subnet_id  = data.azurerm_subnet.kubesubnet.id
    enable_auto_scaling = true
    min_count           = var.min_count
    max_count           = var.max_count
    max_pods        = var.max_pods
    type            = var.default_pool_type
  }

  service_principal {
    client_id     = var.aks_service_principal_app_id
    client_secret = var.aks_service_principal_client_secret
  }

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = var.aks_dns_service_ip
    docker_bridge_cidr = var.aks_docker_bridge_cidr
     service_cidr       = var.aks_service_cidr
    network_policy     = "azure"
  }

  role_based_access_control {
    enabled = var.aks_enable_rbac
    azure_active_directory {
    managed = true
    # Groupname - AZ-Admin-Azure-AIM-AKS
    admin_group_object_ids = [var.ad_admin_obj_id]
  }
  }

}

module "aks_cluster" {
  source                   = "../modules/aks-cluster"
  cluster_name             = var.cluster_name
  location                 = var.location
  dns_prefix               = var.dns_prefix
  resource_group_name      = azurerm_resource_group.aks.name
  kubernetes_version       = var.kubernetes_version
  node_count               = var.node_count
  min_count                = var.min_count
  max_count                = var.max_count
  os_disk_size_gb          = "1028"
  max_pods                 = "110"
  vm_size                  = var.vm_size
  vnet_subnet_id           = module.aks_network.aks_subnet_id
  //client_id                = module.aks_identities.cluster_client_id
  //client_secret            = module.aks_identities.cluster_sp_secret
  diagnostics_workspace_id = module.log_analytics.azurerm_log_analytics_workspace
}







