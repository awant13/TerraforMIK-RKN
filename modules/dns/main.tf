terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }
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

resource "routeros_ip_dns" "dns-server" {
  allow_remote_requests = true
  servers = [
    "1.1.1.1"
  ]
  use_doh_server = "https://cloudflare-dns.com/dns-query"
  verify_doh_cert = "true"
  doh_max_server_connections = "15"
  doh_max_concurrent_queries = "300"
  doh_timeout = "5.000"
  address_list_extra_time = "1d"

}
