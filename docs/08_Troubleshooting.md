# Troubleshooting

- **Access lost after VLAN changes**: Verify bridge port PVIDs:
  ```shell
  /interface bridge port print
  ```
- **DNS resolution issues**: Check static entries and flush cache:
  ```shell
  /ip dns static print
  /ip dns cache flush
  ```
- **Proxmox VM network script errors**: Ensure sub-interface exists and is in `bridge-vlan-aware` mode.
- **TrueNAS HTTPS forced**: Revert via console or UI (System > General > GUI).
