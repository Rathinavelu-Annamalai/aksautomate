variable "client_id" {
  description = "kubernetes client id"
  //default     = "5ff022ff-73b4-464c-87b2-57f8ddced9d8"
}

variable "client_secret" {
  description = "kubernetes client secret"
 // default     = "password"
}

variable "node_count" {
  description = "number of nodes to deploy"
  default     = 2
}

variable "dns_prefix" {
  description = "DNS Suffix"
  default     = "runitoncloud"
}

variable cluster_name {
  description = "AKS cluster name"
  default     = "dev4-runItOnCloud"
}

variable resource_group_name {
  description = "name of the resource group to deploy AKS cluster in"
  default     = "dev4-runitoncloud"
}

variable location {
  description = "azure location to deploy resources"
  default     = "Central Us"
}

variable log_analytics_workspace_name {
  default = "dev4-LogAnalyticsWorkspaceName"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
  default = "Central Us"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing
variable log_analytics_workspace_sku {
  default = "PerGB2018"
}

variable subnet_name {
  description = "subnet id where the nodes will be deployed"
  default     = "dev4-runitoncloud-subnet"
}

variable vnet_name {
  description = "vnet id where the nodes will be deployed"
  default     = "dev4-runitoncloud-vnet"
}

variable subnet_cidr {
  description = "the subnet cidr range"
  default     = "10.2.32.0/21"
}

variable kubernetes_version {
  description = "version of the kubernetes cluster"
  default     = "1.17.13"
}

variable "vm_size" {
  description = "size/type of VM to use for nodes"
  default     = "Standard_D2_v2"
}

variable "os_disk_size_gb" {
  description = "size of the OS disk to attach to the nodes"
  default     = 512
}

variable "max_pods" {
  description = "maximum number of pods that can run on a single node"
  default     = "100"
}

variable "address_space" {
  description = "The address space that is used the virtual network"
  default     = "10.2.0.0/16"
}
variable "min_count" {
  default     = 1
  description = "Minimum Node Count"
}
variable "max_count" {
  default     = 2
  description = "Maximum Node Count"
}
variable "tags" {
type = map
default = {
  environment = "dev-demo"
  CreatedBy = "terraform"
  ModeOfDeployment = "Automation"
}
}