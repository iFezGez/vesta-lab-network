# 01 MikroTik – Core Router Configuration

> **Objective:** Build a repeatable, version‑controlled configuration to bootstrap a MikroTik RB750Gr3 for the Vesta Lab environment.

---
## 1 · Topology & VLAN plan

| VLAN | Name      | CIDR        | Purpose          |
|------|-----------|-------------|------------------|
| 10   | mgmt      | 10.10.0.0/24 | Proxmox / infra management |
| 20   | services  | 10.20.0.0/24 | Internal services (Docker, Portainer) |
| 30   | storage   | 10.30.0.0/24 | PBS ⇆ TrueNAS NFS |
| 40   | dmz       | 10.40.0.0/24 | Reverse‑proxy, SMTP |
| 50   | iot       | 10.50.0.0/24 | Home‑lab devices |
| 60   | guest     | 10.60.0.0/24 | Isolated Wi‑Fi guests |

Diagram omitted for brevity (see `screenshots/`).

---
## 2 · Bridge & Ports

```bash
/interface bridge
add name=bridge-lan protocol-mode=none vlan-filtering=yes
/interface bridge port
add bridge=bridge-lan interface=ether3 comment="Trunk to ve1/ve2"
```

For full listing refer to `config_files/bridge.rsc`.

---
## 3 · VLAN Interfaces

```bash
/interface vlan
add name=vlan10-mgmt interface=bridge-lan vlan-id=10 comment="MGMT VLAN"
```

Full listing in `config_files/vlan.rsc`.

---
## 4 · IP addressing & Routing

```bash
/ip address
add address=10.10.0.1/24 interface=bridge-lan
/ip route
add distance=1 gateway=192.168.1.1
```

---
## 5 · Firewall Filter (minimal hardening)

```
/ip firewall filter
add chain=input action=accept connection-state=established,related
add chain=input action=drop connection-state=invalid
add chain=input action=accept protocol=icmp
add chain=input action=accept src-address=10.10.0.0/24
add chain=input action=drop in-interface-list=WAN
```

Export with:
```bash
/ip firewall filter export file=firewall-filter.rsc
```

---
## 6 · Automated Backup

Backup script in `config_files/vesta-lab-backup.rsc` uploads encrypted exports nightly to a PBS datastore.

---
## 7 · Validation

1. Ping between subnets ‑‑ success.  
2. Proxmox cluster joins via 10.10.0.0/24.  
3. PBS mounts TrueNAS NFS over VLAN 30.

---
## 8 · Result

MikroTik is now a single source‑of‑truth baseline config committed to Git and imported via:
```bash
/import bridge.rsc
/import vlan.rsc
/import addresses.rsc
/import routes.rsc
/import firewall-filter.rsc
```