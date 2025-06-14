# VLAN and Bridge Port Matrix

| VLAN ID | Description     | Tagged Ports                    | Untagged Ports |
|---------|-----------------|---------------------------------|----------------|
| 10      | Management      | bridge-lan, ether2, ether3      | ether4         |
| 20      | Services        | bridge-lan, ether2, ether3      | —              |
| 30      | Storage         | bridge-lan, ether2, ether3      | —              |
| 40      | IoT (only ve2)  | bridge-lan, ether3              | —              |
| 50      | Guest Wi‑Fi     | bridge-lan                      | ether5         |
