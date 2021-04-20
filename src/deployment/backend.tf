terraform {
  backend "azurerm" {
      storage_account_name = "__terraformstorageaccount__"
	    container_name       = "terraform"
	    key                  = "terraform.tfstate"
    	access_key  ="__storagekey__"
		client_id = "__clientid__"
		client_secret="__clientsecret__"
	  features{}
  }
}