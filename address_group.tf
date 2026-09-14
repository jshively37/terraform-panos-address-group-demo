resource "panos_address_group" "demo" {
  location = {
    vsys = {
      name        = var.vsys
      ngfw_device = var.panos_ngfw_device
    }
  }

  name        = var.address_group_name
  description = var.address_group_description

  # Static membership built from every address object above.
  static = [for addr in panos_address.demo : addr.name]
}
