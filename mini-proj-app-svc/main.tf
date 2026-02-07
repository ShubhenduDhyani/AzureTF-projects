#RG
resource "azurerm_resource_group" "rg" {
  name     = "appsvc-rg-tf-mini-proj"
  location = "Central India"
}

#app service plan
resource "azurerm_service_plan" "appsvc-plan" {
  name = "appsvc-plan-tf-mini-proj"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name = "S1"
  os_type = "Linux"  
}

#app service
resource "azurerm_linux_web_app" "appsvc1" {
  name = "linux-webapp-1hjgJAd"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id = azurerm_service_plan.appsvc-plan.id
  site_config {}
}

#deployment slot
resource "azurerm_linux_web_app_slot" "appsvc-slot-1" {
    name = "staging-slot-1"
    site_config {}
    app_service_id = azurerm_linux_web_app.appsvc1.id
}

#app deployment to default slot
resource "azurerm_app_service_source_control" "default-slot" {
  app_id = azurerm_linux_web_app.appsvc1.id
  repo_url = "https://github.com/ShubhenduDhyani/awesome-terraform-tst"
  branch = "main"
}

#app deployment to staging slot
resource "azurerm_app_service_source_control_slot" "staging-slot" {
  slot_id = azurerm_linux_web_app_slot.appsvc-slot-1.id
  repo_url = "https://github.com/ShubhenduDhyani/awesome-terraform-tst"
  branch = "appServiceSlot_Working_DO_NOT_MERGE"
}