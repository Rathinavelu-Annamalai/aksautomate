# Cluster Identity
output "cluster_client_id" {
  value = "azuread_service_principal.cluster_sp.application_id"
   // value="5ff022ff-73b4-464c-87b2-57f8ddced9d8"
}

output "cluster_sp_secret" {
  sensitive = true
  //value     = "test123"
}

