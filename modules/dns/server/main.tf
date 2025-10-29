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

resource "routeros_ip_dns" "dns-server" {
  allow_remote_requests = true
  servers = var.net_settings.dns.server
  use_doh_server = var.net_settings.dns.doh_server
  verify_doh_cert = var.net_settings.dns.verify_doh_cert
  doh_max_server_connections = var.net_settings.dns.doh_max_server_connections
  doh_max_concurrent_queries = var.net_settings.dns.doh_max_concurrent_queries
  doh_timeout = var.net_settings.dns.doh_timeout
  address_list_extra_time = var.net_settings.dns.address_list_extra_time

}