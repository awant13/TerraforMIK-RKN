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

resource "routeros_ip_firewall_mangle" "rule" {
  action            = "mark-routing"
  chain             = "prerouting"
  dst_address_list  = var.net_settings.routes.routing_table
  in_interface_list = "LAN"
  new_routing_mark  = var.net_settings.routes.routing_table
  passthrough       = true
  comment           = "Terraform managed"
}