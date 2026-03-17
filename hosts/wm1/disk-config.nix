# Before install create a password for luks
# echo "secret_passowrd" > /tmp/secret.key
# chmod 600 /tmp/secret.key

{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vda"; # lsblk to check actual device name
        content = {
          type = "gpt";
          partitions = {
            bios_boot = {
              size = "1M";
              type = "EF02"; # BIOS boot
              content = { type = "gpt_bios_boot"; };
            };
            boot = {
              size = "500M";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/boot";
              };
            };
            swap = {
              size = "4G";
              content = {
                type = "luks";
                name = "swap-crypted";
                passwordFile = "/tmp/secret.key";
                content = {
                  type = "swap";
                  resumeDevice = true;
                };
              };
            };
            root = {
              size = "25G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
            home = {
              size = "100%";
              content = {
                type = "luks";
                name = "home-crypted";
                passwordFile = "/tmp/secret.key";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/home";
                };
              };
            };
          };
        };
      };
    };
  };
}
