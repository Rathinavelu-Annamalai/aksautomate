variable "cluster_name" {
  description = "cluster name"
}

variable "tags" {
type = map
default = {
  environment = "dev-demo"
  CreatedBy = "terraform"
  ModeOfDeployment = "Automation"
}
}