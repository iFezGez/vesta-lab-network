# IP Address Plan

| Interface      | IP Address     | Network        | Comment                 |
|----------------|----------------|----------------|-------------------------|
| ether1         | 10.0.0.102/24  | 10.0.0.0/24    | WAN link                |
| vlan10-mgmt    | 10.10.0.1/24   | 10.10.0.0/24   | MGMT GW (tagged)        |
| vlan20-svc     | 10.20.0.1/24   | 10.20.0.0/24   | Services                |
| vlan30-stor    | 10.30.0.1/24   | 10.30.0.0/24   | Storage                 |
| vlan50-iot     | 10.50.0.1/24   | 10.50.0.0/24   | IoT                     |
| vlan60-guest   | 10.60.0.1/24   | 10.60.0.0/24   | Guest                   |
