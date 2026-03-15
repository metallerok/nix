# Install

Before install create a password for luks

```bash
echo "secret_passowrd" > /tmp/secret.key
```

```bash
chmod 600 /tmp/secret.key
```

## Clone repo
```bash
git clone https://github.com/metallerok/nix.git
```


## Disk Configuration

```bash
cp nix/disk-config.nix /tmp/disk-config.nix
```

Update the device path in `/tmp/disk-config.nix` according to your disk layout by running `lsblk`
```bash
lsblk
vim /tmp/disk-config.nix
```

After updating, run disko to format and mount the disk:
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disk-config.nix
```

Check that the disk is mounted:
```bash
mount | grep /mnt
```