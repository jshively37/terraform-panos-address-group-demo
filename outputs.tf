output "address_group_name" {
  description = "Name of the address group managed by this configuration."
  value       = panos_address_group.demo.name
}

output "address_group_members" {
  description = "Address object names that are static members of the address group."
  value       = panos_address_group.demo.static
}

output "address_objects" {
  description = "Map of address object name to its configured value (netmask/range/fqdn)."
  value = {
    for name, addr in panos_address.demo :
    name => coalesce(addr.ip_netmask, addr.ip_range, addr.fqdn)
  }
}
