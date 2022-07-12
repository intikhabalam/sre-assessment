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
    enable_auto_scaling = true
    name                = "default"
    node_count          = 2
    vm_size             = "Standard_D2_v2"
  }

  auto_scaler_profile {
    balance_similar_node_groups      = false
    max_graceful_termination_sec     = "600"
    scale_down_delay_after_add       = "10m"
    scale_down_delay_after_delete    = "10s"
    scale_down_delay_after_failure   = "3m"
    scale_down_unneeded              = "10m"
    scale_down_unready               = "20m"
    scale_down_utilization_threshold = "0.5"
    scan_interval                    = "10s"
    skip_nodes_with_local_storage    = true
    skip_nodes_with_system_pods      = true
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
