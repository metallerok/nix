{ self, inputs, ... }: {
  flake.nixosModules.networking = { pkgs, ... }:
  {
    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    #

    # ==============================
    # Strongswan
    # ==============================
    # Need reboot system to apply this changes

    security.pki.certificateFiles = [
      "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
    ];

    environment.etc."/ssl/certs/isrgrootx1.pem".source =
      (pkgs.fetchurl {
        url = "https://letsencrypt.org/certs/isrgrootx1.pem";
        sha256 = "1la36n2f31j9s03v847ig6ny9lr875q3g7smnq33dcsmf2i5gd92";
      });

      environment.etc."/ipsec.d/cacerts".source =
        "${pkgs.cacert}/etc/ssl/certs";

    services.strongswan = {
      enable = true;
      secrets = [ "/etc/ipsec.d/ipsec.secrets" ];
    };
    environment.etc."strongswan.conf".text = ''
    charon {
      load_modular = yes
      plugins {
        include strongswan.d/charon/*.conf
        x509 {
          load_system_certs = yes
        }
      }
    }

    include strongswan.d/*.conf
    '';
    networking.networkmanager = {
      enable = true;
      plugins = [
        pkgs.networkmanager-l2tp
        pkgs.networkmanager-strongswan
      ];
    };

    services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };
}