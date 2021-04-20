# Cluster Identity
data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "example" {
}

resource "azuread_application" "cluster_aks" {
  name = var.cluster_name
  }

resource "azuread_service_principal" "cluster_sp" {
  application_id = azuread_application.cluster_aks.application_id
}
/*
resource "random_string" "cluster_sp_password" {
  length  = 32
  special = true
  keepers = {
    service_principal = azuread_service_principal.cluster_sp.id
  }
}*/
resource "azurerm_azuread_service_principal_password" "cluster_sp_password" {
  service_principal_id = "${azuread_service_principal.cluster_sp.id}"
  value                = "test123"
  end_date             = "2021-12-12T01:02:03Z" 
}
resource "azurerm_role_assignment" "test" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Contributor" # such as "Contributor"
  principal_id         = "${azuread_service_principal.cluster_sp.id}"
}

/*
resource "azuread_service_principal_password" "cluster_sp_password" {
  service_principal_id = azuread_service_principal.cluster_sp.id
  value                = random_string.cluster_sp_password.result

  # 1 year since creation
  # https://www.terraform.io/docs/configuration/functions/timeadd.html
  end_date = timeadd(timestamp(), "8760h")

  lifecycle {
    ignore_changes = [end_date]
  }
}
*/