# jun/13/2025 22:58:03 by RouterOS 6.49.18
# software id = 9C3N-NVQ7
#
# model = RB750Gr3
# serial number = HGX0A7DFSKS
/interface bridge
add name=bridge-lan protocol-mode=none vlan-filtering=yes
/interface vlan
add arp=proxy-arp interface=bridge-lan name=vlan10-mgmt vlan-id=10
add interface=bridge-lan name=vlan20-svc vlan-id=20
add interface=bridge-lan name=vlan30-stor vlan-id=30
add interface=bridge-lan name=vlan40-dmz vlan-id=40
add interface=bridge-lan name=vlan50-iot vlan-id=50
add interface=bridge-lan name=vlan60-guest vlan-id=60
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=pool10 ranges=10.10.0.100-10.10.0.200
add name=pool20 ranges=10.20.0.100-10.20.0.200
add name=pool30 ranges=10.30.0.100-10.30.0.200
add name=pool40 ranges=10.40.0.100-10.40.0.200
add name=pool50 ranges=10.50.0.100-10.50.0.200
add name=pool60 ranges=10.60.0.100-10.60.0.200
add name=dhcp-pool-vlan20 ranges=10.20.0.100-10.20.0.199
/ip dhcp-server
add address-pool=pool10 disabled=no interface=vlan10-mgmt lease-time=12h \
    name=dhcp10
add address-pool=pool20 disabled=no interface=vlan20-svc lease-time=12h name=\
    dhcp20
add address-pool=pool30 disabled=no interface=vlan30-stor lease-time=12h \
    name=dhcp30
add address-pool=pool40 disabled=no interface=vlan40-dmz lease-time=12h name=\
    dhcp40
add address-pool=pool50 disabled=no interface=vlan50-iot lease-time=12h name=\
    dhcp50
add address-pool=pool60 disabled=no interface=vlan60-guest lease-time=12h \
    name=dhcp60
/interface bridge port
add bridge=bridge-lan comment="Trunk ve2" interface=ether3
add bridge=bridge-lan interface=ether1
add bridge=bridge-lan interface=ether2
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/interface bridge vlan
add bridge=bridge-lan tagged=bridge-lan,ether2,ether3 vlan-ids=30
add bridge=bridge-lan tagged=bridge-lan,ether2,ether3 vlan-ids=20
add bridge=bridge-lan comment="MGMT FINAL" tagged=bridge-lan,ether2,ether3 \
    untagged=ether4 vlan-ids=10
add bridge=bridge-lan comment="IoT only ve2" tagged=bridge-lan,ether3 \
    vlan-ids=40
add bridge=bridge-lan comment="Guest Wi-Fi" tagged=bridge-lan untagged=ether5 \
    vlan-ids=50
/ip address
add address=10.20.0.1/24 comment=Services interface=vlan20-svc network=\
    10.20.0.0
add address=10.40.0.1/24 comment=DMZ interface=vlan40-dmz network=10.40.0.0
add address=10.50.0.1/24 comment=IoT interface=vlan50-iot network=10.50.0.0
add address=10.60.0.1/24 comment=Guest interface=vlan60-guest network=\
    10.60.0.0
add address=10.30.0.1/24 comment="VLAN30 Storage" interface=vlan30-stor \
    network=10.30.0.0
add address=10.10.0.1/24 comment="MGMT GW (tagged)" interface=vlan10-mgmt \
    network=10.10.0.0
/ip dhcp-client
# DHCP client can not run on slave interface!
add disabled=no interface=ether1 use-peer-dns=no
/ip dhcp-server network
add address=10.10.0.0/24 dns-server=10.0.0.102,1.1.1.1 gateway=10.10.0.1
add address=10.20.0.0/24 dns-server=10.0.0.102,1.1.1.1 gateway=10.20.0.1
add address=10.30.0.0/24 dns-server=10.0.0.102,1.1.1.1 gateway=10.30.0.1
add address=10.40.0.0/24 dns-server=10.0.0.102,1.1.1.1 gateway=10.40.0.1
add address=10.50.0.0/24 dns-server=10.0.0.102,1.1.1.1 gateway=10.50.0.1
add address=10.60.0.0/24 dns-server=10.0.0.102,1.1.1.1 gateway=10.60.0.1
/ip dns
set allow-remote-requests=yes servers=1.1.1.1,8.8.8.8
/ip dns static
add address=10.20.0.2 name=gitlab.vestasec.com
add address=10.20.0.2 name=vault.vestasec.com
add address=10.20.0.2 name=portainer.vestasec.com
add address=10.20.0.2 name=ve1-portainer.vestasec.com
add address=10.20.0.2 name=ve2-portainer.vestasec.com
add address=10.20.0.2 name=grafana.vestasec.com
add address=10.20.0.2 name=pbs.vestasec.com
add address=10.20.0.2 name=kuma.vestasec.com
add address=10.20.0.2 name=odoo.vestasec.com
add address=10.20.0.2 name=adguard.vestasec.com
add address=10.20.0.2 comment="Proxmox ve1" name=ve1.vestasec.com
add address=10.20.0.2 comment="Proxmox ve2" name=ve2.vestasec.com
add address=10.30.0.2 comment=PBS name=pbs.vestasec.com
add address=10.20.0.2 comment=TrueNAS name=truenas.vestasec.com
/ip firewall filter
add action=accept chain=forward comment="Allow Established" connection-state=\
    established,related
add action=accept chain=forward comment="VLAN10 to WiFi" dst-address=\
    10.0.0.0/24 src-address=10.10.0.0/24
add action=accept chain=forward comment="VLAN30  VLAN20 (storageservices)" \
    dst-address=10.20.0.0/24 src-address=10.30.0.0/24
add action=accept chain=forward comment="VLAN20VLAN30 servicesstorage" \
    dst-address=10.30.0.0/24 src-address=10.20.0.0/24
add action=accept chain=forward comment="VLAN30VLAN20 storageservices" \
    dst-address=10.20.0.0/24 src-address=10.30.0.0/24
add action=accept chain=forward comment="WiFi  VLAN10 (GUI access)" \
    dst-address=10.10.0.0/24 src-address=10.0.0.0/24
add action=accept chain=forward comment="WiFi  VLAN30 (Full Access)" \
    dst-address=10.30.0.0/24 src-address=10.0.0.0/24
add action=accept chain=forward comment="VLAN10  VLAN30 (PVEPBS)" \
    dst-address=10.30.0.0/24 src-address=10.10.0.0/24
add action=accept chain=forward comment="VLAN30  VLAN10 (PBSPVE)" \
    dst-address=10.10.0.0/24 src-address=10.30.0.0/24
add action=accept chain=forward comment="WiFi  VLAN20 (Services)" \
    dst-address=10.20.0.0/24 src-address=10.0.0.0/24
add action=accept chain=forward comment="VLAN20  WiFi" dst-address=\
    10.0.0.0/24 src-address=10.20.0.0/24
add action=accept chain=forward comment="VLAN20VLAN10  (NPMPVE)" dst-address=\
    10.10.0.0/24 src-address=10.20.0.0/24
add action=accept chain=forward comment="VLAN10VLAN20  (PVENPM)" dst-address=\
    10.20.0.0/24 src-address=10.10.0.0/24
add action=drop chain=forward comment="Default Drop"
add action=accept chain=forward comment="Allow established" connection-state=\
    established,related
add action=accept chain=forward comment="Allow established" connection-state=\
    established,related
/ip firewall nat
add action=masquerade chain=srcnat comment="NAT para salida a Internet" \
    out-interface=bridge-lan
add action=masquerade chain=srcnat comment="NAT para salida a Internet" \
    out-interface=bridge-lan
/system clock
set time-zone-name=America/Costa_Rica
/system note
set show-at-login=no
