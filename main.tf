terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.89.0"
    }
  }
}

provider "routeros" {
  hosturl  = local.creds.host
  username = local.creds.username
  password = local.creds.password
  insecure = local.creds.insecure
}

locals {
  domain = yamldecode(file("${path.module}/domains.yaml"))["domains"]
  settings = yamldecode(file("${path.module}/settings.yaml"))["settings"]
  creds    = local.settings["cred"]
  }

module "dns" {
  for_each = toset(local.domain)
  source   = "./modules/dns"

  domain = each.key
}

module "tun" {
  source   = "./modules/tun"

  net_settings = local.settings
}

module "fw" {
  source   = "./modules/fw"

  net_settings = local.settings
}