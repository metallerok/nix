# Installation Process with Flakes - Detailed Guide

## Why new structure works

With flakes, you don't need to copy configuration to `/etc/nixos/`. Instead, you install directly from your git repository using:

```bash
sudo nixos-install --flake /path/to/your/nix/config/#default
```

The `#default` part specifies which host configuration to use from `flake.nix`.

## Complete Installation Steps

### 1. Boot into NixOS installer

Boot from NOSO installation media and open terminal.

### 2. Prepare LUKS password

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

Edit `disk-config.nix` and update the device path (line 10):

```nix
device = "/dev/nvme0n1";  # or /dev/sda, etc.
```

### 5. Format and mount disk with disko

```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/nix/disk-config.nix
```

Check mount:

```bash
mount | grep /mnt
```

### 6. Generate hardware configuration

```bash
nixos-generate-config --no-filesystems --root /mnt
```

Copy generated hardware config to your structure:

```bash
cp /mnt/etc/nixos/hardware-configuration.nix /tmp/nix/hosts/default/hardware-configuration.nix
```

### 7. Install system from your flake

```bash
sudo nixos-install --flake /tmp/nix/#default
```

### 8. Reboot

```bash
reboot
```

After reboot, login as root and set password for administrator user:

```bash
passwd administrator
```

## What happens during installation

The `nixos-install --flake /tmp/nix/#default` command:

1. Reads `/tmp/nix/flake.nix`
2. Finds `nixosConfigurations.default` definition
3. Loads all imports from `hosts/default/configuration.nix`
4. Includes home-manager and niri modules
5. Builds the complete system
6. Installs to `/mnt`

## Understanding the flake structure

In `flake.nix`:

```nix
outputs = { self, nixpkgs, home-manager, niri, ... }:
{
  nixosConfigurations.default = nixpkgs.lib.nixosSystem {
    modules = [
      ./hosts/default/configuration.nix      # Your system config
      ./hosts/default/hardware-configuration.nix  # Hardware-specific
      home-manager.nixosModules.home-manager  # Home manager integration
      {
        home-manager.users.administrator = ./home/administrator;  # User config
      }
      niri.nixosModules.niri  # Niri window manager
    ];
  };
}
```

The `#default` in `--flake /tmp/nix/#default` refers to `nixosConfigurations.default`.

## After installation

Your system configuration is installed, but you still have your source files in `/tmp/nix`. For everyday use:

```bash
# Copy to your home directory for easy access
sudo cp -r /tmp/nix /home/administrator/nix-config
sudo chown -R administrator:administrator /home/administrator/nix-config

# Apply changes from there
cd /home/administrator/nix-config
sudo nixos-rebuild switch --flake .#default
```
