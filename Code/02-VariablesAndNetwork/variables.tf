
variable "project-name" {
  type    = string
  default = "DevOpsCamp"
}

variable "environment" {
  type    = string
  default = "Dev"
  validation {
    condition     = contains(["Dev", "Prod"], var.environment)
    error_message = "Possible values for environment are \"Dev\" or \"Prod\"."
  }
}


variable "az-region" {
  type = map(any)
  default = {
    "Dev"  = "West Europe"
    "Prod" = "East US"
  }
}


