Challenge #1
A 3-tier environment is a common setup. Use a tool of your choosing/familiarity create these resources. Please remember we will not be judged on the outcome but more focusing on the approach, style and reproducibility.

provider "azurerm" {
  version="1.44.0"
  subscription_id      = "${var.subscription_id}"
  tenant_id            = "${var.tenant_id}"
  client_id            = "${var.client_id}"
  client_secret        = "${var.client_secret}"
}

#Creating Resource group
resource "azurerm_resource_group" "rgroup" {
  name                = "${var.resource_group_name}"
  location            = "${var.location}"   
}

#Creating virtual_network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnetname}"
  location            = "${azurerm_resource_group.rgroup.location}"
  resource_group_name = "${azurerm_resource_group.rgroup.name}"
  address_space       = ["10.0.0.0/16"]
  
  
}

#Creating app_service_plan
resource "azurerm_app_service_plan" "appplan" {
  name                = "${var.app_serviceplan_name}"
  location            = "${azurerm_resource_group.rgroup.location}"
  resource_group_name = "${azurerm_resource_group.rgroup.name}"
  
  sku {
    tier = "${var.tier}"
    size = "${var.size}"
  }
}


#Creating app service
resource "azurerm_app_service" "appservice" {
  name                = "${var.appservice_name}"
  location            = "${azurerm_resource_group.rgroup.location}"
  resource_group_name = "${azurerm_resource_group.rgroup.name}"
  app_service_plan_id = "${azurerm_app_service_plan.appplan.id}"

  site_config {
    dotnet_framework_version = "${var.dotnet_version}"
    scm_type                 = "${var.scm_type}"
    default_documents = ["Default.html"]
  }

  connection_string {
    name  = "${var.sql_db_name}"
    type  = "SQLServer"
    #value = "Server=some-server.mydomain.com;Integrated Security=SSPI"(SQL)
    value = "Server= ${var.sqlserver_name};Database=${var.sql_db_name};User=${var.admin_login};Password=${var.admin_password};"

  }

}

#Creating sql server
resource "azurerm_sql_server" "sqlserver" {
  name                         = "${var.sqlserver_name}"
  resource_group_name          = "${azurerm_resource_group.rgroup.name}"
  location                     = "${azurerm_resource_group.rgroup.location}"
  version                      = "${var.sql_version}"
  administrator_login          = "${var.admin_login}"
  administrator_login_password = "${var.admin_password}"
}

#Creating sql database
resource "azurerm_sql_database" "db" {
  name                                  = "${var.sql_db_name}"
  resource_group_name                   = "${var.resource_group_name}"
  location                              = "${var.location}"
  edition                               = "${var.sql_db_edition}"
  create_mode                           = "${var.sql_db_create_mode}"
  requested_service_objective_name      = "${var.sql_db_requested_service_objective_name}"
  server_name                           = "${azurerm_sql_server.sqlserver.name}"
}

#Creating firewall rule for sql 
resource "azurerm_sql_firewall_rule" "sqlfirewallrule" {
  name                = "${var.sql_FirewallRule_name}"
  resource_group_name = "${azurerm_resource_group.rgroup.name}"
  server_name         = "${azurerm_sql_server.sqlserver.name}"
  start_ip_address    = "${var.start_ip_address}"
  end_ip_address      = "${var.end_ip_address}"
}

