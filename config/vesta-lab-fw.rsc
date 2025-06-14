# jun/13/2025 22:58:59 by RouterOS 6.49.18
# software id = 9C3N-NVQ7
#
# model = RB750Gr3
# serial number = HGX0A7DFSKS
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
