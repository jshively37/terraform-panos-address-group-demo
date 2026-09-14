# terraform-panos-address-group-demo

A minimal demo of the [`PaloAltoNetworks/panos`](https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest)
Terraform provider: it creates a handful of `panos_address` objects and adds
them as static members of a `panos_address_group`, on a **single NGFW managed
locally** — connecting directly to the firewall's management interface, not
through Panorama or Strata Cloud Manager.

Locality comes from the `location` block on each resource: everything targets
`vsys` (a virtual system on the firewall itself) instead of a `device_group`
or `template` (which are Panorama-only concepts).

## What it creates

- `panos_address.demo` — one address object per entry in `var.addresses`
  (a mix of host IPs, a subnet, and an FQDN by default)
- `panos_address_group.demo` — a static address group whose membership is
  derived from every object above (`static = [for addr in panos_address.demo : addr.name]`)

Change, add, or remove entries in `var.addresses` and re-apply to see the
group's membership update.

## Files

| File | Purpose |
|---|---|
| `versions.tf` | Provider version pin |
| `provider.tf` | Connection to the NGFW's management interface |
| `variables.tf` | Connection settings, vsys, and the `addresses` map |
| `addresses.tf` | `panos_address` resources |
| `address_group.tf` | `panos_address_group` resource |
| `outputs.tf` | Group name, members, and object values |
| `terraform.tfvars.example` | Template for your own `terraform.tfvars` |

## Usage

```sh
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars with your NGFW's IP and admin credentials

terraform init
terraform plan
terraform apply
```

Credentials can also be supplied via environment variables instead of a
`.tfvars` file:

```sh
export PANOS_HOSTNAME=192.168.1.1
export PANOS_USERNAME=admin
export PANOS_PASSWORD=changeme
```

## Requirements

- Terraform >= 1.8
- A PAN-OS NGFW reachable over HTTPS, with an admin account
- `PaloAltoNetworks/panos` provider ~> 2.0 (installed automatically by `terraform init`)

## License

[MIT](LICENSE)
