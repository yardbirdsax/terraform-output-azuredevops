provider azurerm {}

provider random {}

resource random_string random {
  length = 15
  special = false
}

resource azurerm_resource_group resource_group {
  name = "terraform-output-azuredevops"
  location = "eastus2"
}

resource azurerm_storage_account web {
  account_kind = "StorageV2"
  account_tier = "Standard"
  account_replication_type = "LRS"
  name = random_string.random.result
  location = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

output ado_output {
  value = {
    TF_STORAGE_ACCOUNT_NAME = azurerm_storage_account.web.name
    TF_STORAGE_ACCOUNT_KEY  = azurerm_storage_account.web.primary_access_key
  }
}