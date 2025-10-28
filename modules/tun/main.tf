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

resource "routeros_interface_ipip" "ipip_hq" {
  name            = var.net_settings.tun.name
  remote_address  = var.net_settings.tun.remote_address
  mtu             = var.net_settings.tun.mtu
  ipsec_secret    = var.net_settings.tun.ipsec_secret
  allow_fast_path = "false"
  disabled       = var.net_settings.tun.disabled
  comment         = "Terraform managed"
}

resource "routeros_ip_address" "address" {
  address   = var.net_settings.network.address
  interface = var.net_settings.tun.name
  comment         = "Terraform managed"
}

resource "routeros_routing_table" "tun_table" {
  name = var.net_settings.routes.routing_table
  fib  = true
  comment         = "Terraform managed"
}

resource "routeros_ip_route" "route" {
  dst_address   = "0.0.0.0/0"
  distance      = var.net_settings.routes.distance
  gateway       = var.net_settings.routes.gateway
  routing_table  = var.net_settings.routes.routing_table
  comment         = "Terraform managed"
}