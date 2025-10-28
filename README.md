# Настройка Mikrotik для обхода блокировок РКН

## Схема 
```bash
   [MikroTik HOME]                     [MikroTik VDS]
   +------------+                     +-----------+
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

Тит туннеля IPIP c ipsec

Создать в корне проекта файл settings.yaml
Ввести нужные параметры 

```yaml
settings:
  cred:
    host: api://router.local:8728
    username: admin
    password: admin
    insecure: true
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