
variable "project-name" {
  type    = string
  default = "DevOpsCamp"
}

variable "environment" {
  type    = string
  default = "Dev"
}


variable "az-region" {
  type = map
  default = {
    "Dev"  = "West Europe"
    "Prod" = "North Europe"
  }
}


variable "vnet-addr" {
  type = map
  default = {
    "Dev"  = ["10.10.0.0/16"]
    "Prod" = ["10.20.0.0/16"]
  }
}

variable "subnet" {
  type = map
  default = {
    "Dev"  = ["10.10.1.0/24"]
    "Prod" = ["10.20.2.0/24"]
  }
}