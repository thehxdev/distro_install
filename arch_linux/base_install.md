# Install Base system:

### Connect to internet with Wi-Fi (`iwctl`) or Ethernet (recommended).


### Partition your disk:

Get device names with `lsblk`.

Partition your chosen disk/ssd with `cfdisk` or `fdisk`

It's better to creat a `/boot`, `/home` and `swap` partition with main `/` (root) partition.

* `/boot` ==> 1GB
* `/`     ==> 45GB
* `swap`  ==> a little more than RAM size. (if you want Hiberation give it RAM * 2).
* `/home` ==> All remaning space.

### Format Pratitions with `ext4`

Format `/` and `/home` with `ext4`. **If you use MBR/DOS format `/boot` with `ext4` too:**

* `mkfs.ext4 /dev/sdX`

Format `swap` partition with swap filesystem

* `mkswap /dev/sdX`

If you use UEFI, Then format `/boot` partition with `fat32`:

* `mkfs.fat -F 32 /dev/sdX`

### Mount Partitions

Mount `/` partition to `/mnt`:

* `mount /dev/sdX /mnt`

Then make 2 directories in `/mnt` and mount `/boot` and `/home` partitions:

```bash
mkdir /mnt/home
mkdir /mnt/boot

# Change [X] to partition number.
mount /dev/sdX /mnt/boot
mount /dev/sdX /mnt/home 
```

* `swapon /dev/sdX`

### Install Base system

```bash
pacstrap /mnt base base-devel linux linux-firmware linux-headers vim nano vi git curl
```

### 

Generate `fstab` file.

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

### chroot to new installed ARCH

```bash
arch-chroot /mnt
```


