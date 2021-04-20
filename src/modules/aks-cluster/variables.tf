variable "dns_prefix" {
  description = "DNS prefix"
}

variable "location" {
  description = "azure location to deploy resources"
}
variable "ad_admin_obj_id" {
default= "5fea45e2-9bce-4357-a16f-09c603bf0d12"
}

variable "cluster_name" {
  description = "AKS cluster name"
}

variable "resource_group_name" {
  description = "name of the resource group to deploy AKS cluster in"
}

variable "kubernetes_version" {
  description = "version of the kubernetes cluster"
}

variable "api_server_authorized_ip_ranges" {
  description = "ip ranges to lock down access to kubernetes api server"
  default     = "0.0.0.0/0"
}

# Node Pool config
variable "agent_pool_name" {
  description = "name for the agent pool profile"
  default     = "default"
}

variable "agent_pool_type" {
  description = "type of the agent pool (AvailabilitySet and VirtualMachineScaleSets)"
  default     = "AvailabilitySet"
}

variable "node_count" {
  description = "number of nodes to deploy"
}

variable "vm_size" {
  description = "size/type of VM to use for nodes"
}


variable "os_disk_size_gb" {
  description = "size of the OS disk to attach to the nodes"
}

variable "vnet_subnet_id" {
  description = "vnet id where the nodes will be deployed"
}

variable "max_pods" {
  description = "maximum number of pods that can run on a single node"
}

#Network Profile config
variable "network_plugin" {
  description = "network plugin for kubenretes network overlay (azure or calico)"
  default     = "azure"
}

variable "service_cidr" {
  description = "kubernetes internal service cidr range"
  default     = "10.0.0.0/16"
}

variable "diagnostics_workspace_id" {
  description = "log analytics workspace id for cluster audit"
}
variable "client_id" {
description = "kubernetes internal service cidr range"
  default     = "5ff022ff-73b4-464c-87b2-57f8ddced9d8"
}
variable "client_secret" {
description = "kubernetes internal service cidr range"
  default     = "password"
}
variable "min_count" {
  default     = 1
  description = "Minimum Node Count"
}
variable "max_count" {
  default     = 5
  description = "Maximum Node Count"
}
variable "default_pool_name" {
  description = "name for the agent pool profile"
  default     = "default"
}
variable "default_pool_type" {
  description = "type of the agent pool (AvailabilitySet and VirtualMachineScaleSets)"
  default     = "VirtualMachineScaleSets"
}

variable "tags" {
type = map
default = {
  environment = "dev-demo"
  CreatedBy = "terraform"
  ModeOfDeployment = "Automation"
}
}







