# Talks directly to a single, locally-managed NGFW (not Panorama, not Strata
# Cloud Manager). All resources below target the "vsys" location rather than
# a device_group/template location, which is what makes this "local" rather
# than Panorama-managed.

provider "panos" {
  hostname                = var.panos_hostname
  username                = var.panos_username
  password                = var.panos_password
  skip_verify_certificate = var.panos_skip_verify_certificate

  # Alternative: leave username/password unset and instead set the
  # PANOS_HOSTNAME / PANOS_USERNAME / PANOS_PASSWORD (or PANOS_API_KEY)
  # environment variables so credentials never land in .tf/.tfvars files.
}
