# Настройка Mikrotik для обхода блокировок РКН

## Схема 
```bash
   [MikroTik HOME]                     [MikroTik VDS]
   +------------+                    +-----------+
   |            |                    |           |
   |  LAN A     |                    |  LAN B    |
   | 10.0.1.0/24|                    |10.0.2.0/24|
   |            |                    |           |
   +------------+                    +-----------+
         |                                 |
         | Public IP A                     | Public IP B
         | 5.1.1.1                         | 5.2.2.2
         |                                 |
   +-------------------------------------------+
   |                IPIP Tunnel                |
   |   Name: ipip-TW                           |
   |   Local: 172.16.133.2/30                  |
   |   Remote: 172.16.133.1/30                 |
   +-------------------------------------------+
```

Тип туннеля IPIP c ipsec

Создать в корне проекта файл settings.yaml
Ввести нужные параметры 

```yaml
settings:
  cred:
    host: api://router.local:8728
    username: admin
    password: admin
    insecure: true
  dns:
    server: 
      - 1.1.1.1
    doh_server: "https://cloudflare-dns.com/dns-query"
    doh_max_server_connections: "15"
    doh_max_concurrent_queries: "300"
    doh_timeout: "5s"
    address_list_extra_time: "1d"
    verify_doh_cert: true
  tun:
    name: ipip-vpn
    remote_address: 1.1.1.1
    ipsec_secret: 12345678
    mtu: 1300
    disabled: false
  network:
    address: "172.16.0.2/30"
  routes:
    routing_table: roskompozor_FWD
    gateway: 172.16.0.1
    distance: 250
```

Вписать нужные домены в domains.yaml


```yaml

domains:
  - googlevideo.com
  - youtube.com
  - youtubei.googleapis.com
  - ytimg.com
  - youtu.be
  - ggpht.com
  - rutracker.org
  - rutracker.cc

  ```

```bash
terraform init
terraform apply
```