variable "panos_hostname" {
  description = "IP address or FQDN of the locally-managed NGFW's management interface."
  type        = string
}

variable "panos_username" {
  description = "Admin username on the NGFW. Leave null to use PANOS_USERNAME env var or an API key instead."
  type        = string
  default     = null
}

variable "panos_password" {
  description = "Admin password on the NGFW. Leave null to use PANOS_PASSWORD env var or an API key instead."
  type        = string
  default     = null
  sensitive   = true
}

variable "panos_skip_verify_certificate" {
  description = "Skip TLS certificate verification when talking to the NGFW (fine for a lab/demo box with a self-signed cert)."
  type        = bool
  default     = true
}

variable "vsys" {
  description = "Virtual system on the NGFW that owns the address objects/group."
  type        = string
  default     = "vsys1"
}

variable "panos_ngfw_device" {
  description = "NGFW device identifier used in the vsys location block. \"localhost.localdomain\" is the standard self-reference for a firewall managed directly (not through Panorama)."
  type        = string
  default     = "localhost.localdomain"
}

variable "address_group_name" {
  description = "Name of the address group to create/update."
  type        = string
  default     = "demo-web-servers"
}

variable "address_group_description" {
  description = "Description for the address group."
  type        = string
  default     = "Demo address group managed by Terraform"
}

variable "addresses" {
  description = "Address objects to create and add as static members of the address group."
  type = map(object({
    description = optional(string)
    ip_netmask  = optional(string)
    ip_range    = optional(string)
    fqdn        = optional(string)
    tags        = optional(list(string), [])
  }))

  default = {
    "web-01" = {
      description = "Web server 1"
      ip_netmask  = "10.0.1.11/32"
      tags        = ["terraform-demo"]
    }
    "web-02" = {
      description = "Web server 2"
      ip_netmask  = "10.0.1.12/32"
      tags        = ["terraform-demo"]
    }
    "web-03" = {
      description = "Web server 3"
      ip_netmask  = "10.0.1.13/32"
      tags        = ["terraform-demo"]
    }
    "app-subnet" = {
      description = "Application subnet"
      ip_netmask  = "10.0.2.0/24"
      tags        = ["terraform-demo"]
    }
    "partner-fqdn" = {
      description = "Partner API endpoint"
      fqdn        = "api.partner.example.com"
      tags        = ["terraform-demo"]
    }
  }

  validation {
    condition = alltrue([
      for a in var.addresses :
      length(compact([a.ip_netmask, a.ip_range, a.fqdn])) == 1
    ])
    error_message = "Each address must set exactly one of ip_netmask, ip_range, or fqdn."
  }
}
