
 resource "azurerm_resource_group" "rg1" {
  name     = local.resource_group_name
  location = local.location  
}

resource "azurerm_virtual_network" "appnetwork" {
   name                = local.virtual_network.name
   location            = local.location
   resource_group_name = local.resource_group_name
   address_space       = [local.virtual_network.address_space] 
  
   depends_on = [
     azurerm_resource_group.rg1
    ]
}

  

resource "azurerm_subnet" "subnets" {
  
  for_each = { 
    for index, sub in local.subnets:
    sub.name => sub
  }
  name                 = each.key
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = [each.value.address_prefix]
  depends_on = [
    azurerm_virtual_network.appnetwork
  ]
}


resource "azurerm_storage_account" "storageveteu1" {  
  name                     = "storageveteu1"
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  depends_on = [
    azurerm_resource_group.rg1
      ]
}

resource "azurerm_storage_container" "data" {
  for_each = toset(["data","files","documents"])
  name                  = each.key
  storage_account_name  = azurerm_storage_account.storageveteu1.name
  container_access_type = "blob"
  depends_on = [
    azurerm_storage_account.storageveteu1
  ]
}



