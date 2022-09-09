# arch install script

A shell script to make installing arch easier.

Use scripts after chroot to `/mnt`. It means you MUST install base system with pacstrap to /mnt.

### Install Base System Command:

```bash
pacstrap /mnt base base-devel linux linux-firmware linux-headers vi vim nano git curl
```
