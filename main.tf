terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.64.0"
    }
  }
  cloud {
    organization = "stavba"
    workspaces {
      name = "veteranieu-workspace"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

module "resource_group_creation" {
  source              = "github.com/stredovek/modules-create-rg.git"
  location            = "westeurope"
  resource_group_name = "MyemptyRG"

}
