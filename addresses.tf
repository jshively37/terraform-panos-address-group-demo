# One panos_address per entry in var.addresses, all local to the NGFW's vsys
# (no device_group/template location => not Panorama-managed).

resource "panos_address" "demo" {
  for_each = var.addresses

  location = {
    vsys = {
      name        = var.vsys
      ngfw_device = var.panos_ngfw_device
    }
  }

  name        = each.key
  description = each.value.description
  ip_netmask  = each.value.ip_netmask
  ip_range    = each.value.ip_range
  fqdn        = each.value.fqdn
  tags        = each.value.tags
}
