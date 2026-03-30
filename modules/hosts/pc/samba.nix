{ self, inputs, ... }: {
  flake.nixosModules.samba = { ... }:
  {
    services.samba = {
      enable = true;
      openFirewall = true;

      settings = {
        global.security = "user";
        shared = {
          path = "/srv/samba/shared";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
      };
    };

    systemd.tmpfiles.rules = [
      "d /srv/samba 0755 root root -"
      "d /srv/samba/shared 0755 administrator administrator -"
    ];

    services.avahi = {
      enable = true;
      openFirewall = true;
    };
  };
}
