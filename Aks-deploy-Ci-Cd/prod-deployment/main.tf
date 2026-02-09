resource "azurerm_resource_group" "rg1" {
  name     = var.rgname
  location = var.location
  tags = local.common_tags
}

module "ServicePrinciple" {
  source                 = "../modules/ServicePrinciple"
  service_principal_name = var.service_principal_name

  depends_on = [
    azurerm_resource_group.rg1
  ]
}

resource "azurerm_role_assignment" "rolespn" {

  scope                = "/subscriptions/${var.SUB_ID}"
  role_definition_name = "Contributor"
  principal_id         = module.ServicePrinciple.service_principal_object_id

  depends_on = [
    module.ServicePrinciple
  ]
}

module "key-vault" {
  source                      = "../modules/key-vault"
  keyvault_name               = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.rgname
  service_principal_name      = var.service_principal_name
  service_principal_object_id = module.ServicePrinciple.service_principal_object_id
  service_principal_tenant_id = module.ServicePrinciple.service_principal_tenant_id

  depends_on = [
    module.ServicePrincipl
  ]
}

resource "azurerm_key_vault_secret" "example" {
  name         = module.ServicePrinciple.client_id
  value        = module.ServicePrinciple.client_secret
  key_vault_id = module.key-vault.keyvault_id

  depends_on = [
    module.key-vault
  ]
}

#create Azure Kubernetes Service
module "aks" {
  source                 = "../modules/aks/"
  service_principal_name = var.service_principal_name
  client_id              = module.ServicePrinciple.client_id
  client_secret          = module.ServicePrinciple.client_secret
  location               = var.location
  resource_group_name    = var.rgname
  vm_size                = var.vm_size
  cluster_name = var.cluster_name
  node_pool_name = var.node_pool_name
  kubernetes_version = var.kubernetes_version

  depends_on = [
    module.ServicePrincipal
  ]

}

resource "local_file" "kubeconfig" {
  depends_on   = [module.aks]
  filename     = "./kubeconfig"
  content      = module.aks.config
  
}