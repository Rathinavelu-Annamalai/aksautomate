
variable "object_id" {
  default = "a1dcb76f-4066-4a88-8946-c7cd649edd64"
}
variable "subscription_id" {
  default = "1d021829-09c2-47de-9160-f9597e6f66ad"
}
variable "client_id" {
  default = "9d1d4732-e93c-49a5-a49c-894df6b5cf89"
}
variable "client_secret" {
  default = "TL3e-H~3Jk.y.bD1HorGk0scyGr4NLxkT_"
}
variable "tenant_id" {
  default = "6e06e42d-6925-47c6-b9e7-9581c7ca302a"
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
  default     = "dev4-runItOnCloud21"
}


variable acr_name {
  description = "ACR name"
  default     = "ACR0211"
}

variable resource_group_name {
  description = "name of the resource group to deploy AKS cluster in"
  default     = "dev4-runitoncloud21"
}

variable location {
  description = "azure location to deploy resources"
  default     = "Central Us"
}

variable log_analytics_workspace_name {
  default = "dev4-LogAnalyticsWorkspaceName21"
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
  default     = "dev4-runitoncloud-subnet21"
}

variable vnet_name {
  description = "vnet id where the nodes will be deployed"
  default     = "dev4-runitoncloud-vnet21"
}

variable subnet_cidr {
  description = "the subnet cidr range"
  default     = "10.2.32.0/21"
}

variable kubernetes_version {
  description = "version of the kubernetes cluster"
  default     = "1.19.6"
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
  default     = null
  description = "Minimum Node Count"
}
variable "max_count" {
  default     = null
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