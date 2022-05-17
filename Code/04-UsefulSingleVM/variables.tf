
variable "project-name" {
  type    = string
  default = "DevOpsCamp"
}

variable "environment" {
  type    = string
  default = "Dev"
}


variable "az-region" {
  type = map(any)
  default = {
    "Dev"  = "West Europe"
    "Prod" = "East US"
  }
}

