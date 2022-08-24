variable "subscription_id" {
    description = "Azure Cloud subscription id"
   
}
variable "tenant_id" {
    description = "Azure Cloud tenant id"
   
}
variable "client_id" {
    description = "Service principal client id"
   
}
variable "client_secret" {
    description = "Service principal client secret"
    
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the MVC Stack."
}
variable "location" {
  description = "The location/region to create the MVC Stack."
}

variable "vnetname" {
   type = "string"
}

variable "app_serviceplan_name" {
  type = "string"
}

variable "tier" {
  default = "Standard"
}

variable "size" {
  default = "S1"
} 



variable "appservice_name" {
    type = "string"
} 

variable "dotnet_version" {
  #default = "v4.0"
} 

variable "scm_type" {
  default = "LocalGit"
}                

variable"sql_db_name" {
  type = "string"
}
variable "sqlserver_name" {
  type = "string"
} 



variable  "sql_version" {
  default = "12.0"
}

variable "admin_login" {
  type = "string"
}

variable "admin_password" {
  type = "string"
}

variable "sql_vnet_rule_name" {
  type = "string"
}

variable  "sql_FirewallRule_name" {
  type = "string"
}

variable  "start_ip_address" {
  type = "string"
}

variable  "end_ip_address" {
  type = "string"
}

variable "sql_db_edition" {
  description = "The edition of the database to be created. Applies only if create_mode is Default. Valid values are: Basic, Standard, Premium, or DataWarehouse."
  default="Basic"
}
variable "sql_db_create_mode" {
  description = "Specifies the type of database to create. Defaults to Default."
  default="Default"
}

variable "sql_db_requested_service_objective_name" {
  description = "Use requested_service_objective_name or requested_service_objective_id to set the performance level for the database. Valid values are: S0, S1, S2, S3, P1, P2, P4, P6, P11 and ElasticPool."
  default="Basic"
}
