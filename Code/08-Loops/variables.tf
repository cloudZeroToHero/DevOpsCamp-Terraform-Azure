
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

variable "ssh-source-addresss"{ # I can put my IP address there to mitigate vulnerability 
  type = string
  default = "*"
}


variable "az-region" {
  type = map
  default = {
    "Dev"  = "eastus"
    "Prod" = "westus"
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


variable "allowedPorts" {
  default =[
    {  # Web
      name="web"
      destPort="80"
      priority = 150
    },

    {  #SSH
      name="ssh"
      destPort="22"
      priority = 151
    }
  ]
}