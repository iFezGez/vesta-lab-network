# Backup and Restore

## Manual Backups

- Export full config:
  ```shell
  /export hide-sensitive file=vesta-lab-full-config
  ```
- Export firewall rules:
  ```shell
  /ip firewall filter export file=vesta-lab-fw
  ```
- Export system scripts:
  ```shell
  /system script export file=vesta-lab-scripts
  ```

## Restore

1. Upload the `.rsc` file to the router (via FTP/Winbox).
2. Import:
   ```shell
   /import file-name=<FILENAME>
   ```
