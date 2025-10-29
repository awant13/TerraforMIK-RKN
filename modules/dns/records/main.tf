terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }
}

variable "net_settings" {
  type = any
}

variable "domain" {
  type = any
}

resource "routeros_dns_record" "fwd_record" {
  name            = var.domain
  forward_to      = "localhost"
  address_list    = "roskompozor_FWD"
  match_subdomain = "true"
  comment         = "Terraform managed"
  type            = "FWD"
}
