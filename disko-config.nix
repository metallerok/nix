# Before install create a password for luks
# echo "secret_passowrd" > /tmp/secret.key
# chmod 600 /tmp/secret.key

{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vdb";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              size = "8G";
              settings.allowDiscards = true;
              content = {
                type = "luks";
                name = "swap-crypted";
                passwordFile = "/tmp/secret.key"; # Same password as for home
                content = {
                  type = "swap";
                  resumeDevice = true; #  For hibernation
                };
              };
            };
            root = {
              size = "30G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
            home = {
              size = "100%"; # All awailable space
              content = {
                type = "luks";
                name = "home-crypted";
                settings.allowDiscards = true;
                passwordFile = "/tmp/secret.key"; # Only for install
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