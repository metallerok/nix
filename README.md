# NixOS Configuration with Flakes

This is a NixOS configuration using flakes, home-manager, and niri window manager.

## Installation

### 1. Boot into NixOS installer

Boot from NixOS installation media and open terminal.

### 2. Create LUKS password

```bash
echo "your_password" > /tmp/secret.key
chmod 600 /tmp/secret.key
```

### 3. Clone your configuration

```bash
git clone https://github.com/metallerok/nix.git /tmp/nix
cd /tmp/nix
```

### 4. Update disk configuration

Find your disk name:
```bash
lsblk
```

### Copy disk configuration

```bash
cp /tmp/nix/hosts/{hostname}/disk-config.nix /tmp/disk-config.nix
```

Edit `disk-config.nix` and update the device path (line 10):
```bash
vim disk-config.nix
# Change: device = "/dev/<device-name>";
# To: device = "/dev/nvme0n1";  # or /dev/sda, etc.
```

### 5. Format and mount disk with disko

```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disk-config.nix
```

Check mount:
```bash
mount | grep /mnt
```

### 6. Generate hardware configuration

```bash
nixos-generate-config --no-filesystems --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix /tmp/nix/hosts/{hostname}/hardware-configuration.nix
```

### 7. Install system from your flake

**Important**: With flakes, you don't need to copy files to `/etc/nixos/`. Install directly from your git repository:

```bash
sudo nixos-install --flake /tmp/nix/#{hostname}
```

### 8. Reboot and configure user

```bash
reboot
```

After reboot, login as root and set password:
```bash
passwd administrator
```

### 9. Copy configuration to your home directory

For everyday use:

```bash
# As administrator user after login
sudo cp -r /tmp/nix /home/administrator/nix-config
sudo chown -R administrator:administrator /home/administrator/nix-config
cd /home/administrator/nix-config
```

## Usage

### Apply configuration changes

```bash
sudo nixos-rebuild switch --flake .#default
```

### Update system

```bash
sudo nix flake update
sudo nixos-rebuild switch --flake .#default
```

### Apply home-manager changes only

```bash
home-manager switch --flake .#default
```

## Default User

The default user is `administrator`. Set a password after first boot:

```bash
passwd administrator
```
