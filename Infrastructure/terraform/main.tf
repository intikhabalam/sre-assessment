# create azure container registry
resource "azurerm_container_registry" "clearpoint" {
  name                = "clearpointacr"
  resource_group_name = "clearpointresgrpiac"
  location            = "eastus"
  sku                 = "Premium"

}

# create azure kubernetes cluster
resource "azurerm_kubernetes_cluster" "clearpoint" {
  name                = "clearpoint-aks"
  location            = "eastus"
  resource_group_name = "clearpointresgrpiac"
  dns_prefix          = "clearpointaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

# link the ACR with AKS using role assignment
resource "azurerm_role_assignment" "clearpoint" {
  principal_id                     = azurerm_kubernetes_cluster.clearpoint.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.clearpoint.id
  skip_service_principal_aad_check = true
}
