# Firewall Rules Summary

| #  | Comment                                  | Action | Src Address      | Dst Address      |
|----|------------------------------------------|--------|------------------|------------------|
| 0  | Allow Established                        | accept | established,related | —              |
| 1  | VLAN10 to WiFi                           | accept | 10.10.0.0/24     | 10.0.0.0/24      |
| 2  | VLAN30 → VLAN20 (storageservices)        | accept | 10.30.0.0/24     | 10.20.0.0/24     |
| 3  | VLAN20 → VLAN30 (servicesstorage)        | accept | 10.20.0.0/24     | 10.30.0.0/24     |
| 4  | VLAN30 → VLAN20 (storageservices)        | accept | 10.30.0.0/24     | 10.20.0.0/24     |
| 5  | WiFi → VLAN10 (GUI access)               | accept | 10.0.0.0/24      | 10.10.0.0/24     |
| 6  | WiFi → VLAN30 (Full Access)              | accept | 10.0.0.0/24      | 10.30.0.0/24     |
| 7  | VLAN10 → VLAN30 (PVEPBS)                 | accept | 10.10.0.0/24     | 10.30.0.0/24     |
| 8  | VLAN30 → VLAN10 (PBSPVE)                 | accept | 10.30.0.0/24     | 10.10.0.0/24     |
| 9  | WiFi → VLAN20 (Services)                 | accept | 10.0.0.0/24      | 10.20.0.0/24     |
| 10 | VLAN20 → WiFi                            | accept | 10.20.0.0/24     | 10.0.0.0/24      |
| 11 | VLAN20 → VLAN10 (NPMPVE)                 | accept | 10.20.0.0/24     | 10.10.0.0/24     |
| 12 | VLAN10 → VLAN20 (PVENPM)                 | accept | 10.10.0.0/24     | 10.20.0.0/24     |
| 13 | Default Drop                             | drop   | any              | any              |
