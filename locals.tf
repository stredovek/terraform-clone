locals {
  resource_group_name="deletemeafter"
  location="West Europe"

 virtual_network={
    name="network-veterani"
    address_space="10.5.0.0/16"
  }

  subnets=[
    {
      name="Networkgateway"
      address_prefix="10.5.0.0/24"
    },
    {
      name="vda"
      address_prefix="10.5.1.0/24"
    },
    {
     name="infra"
      address_prefix="10.5.2.0/24"   
    }

  ]
  }