{ self, inputs, ... }: {
  flake.nixosModules.pcConfiguration = { pkgs, lib, ... }:
	let
	    system = pkgs.stdenv.hostPlatform.system;
      pkgsUnstable = import inputs.nixpkgs-unstable {
        system = pkgs.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
	in
  {
    imports = [
      self.nixosModules.pcHardware
      self.nixosModules.niri
      inputs.home-manager.nixosModules.home-manager
    ];

    nixpkgs.config = {
      allowUnfree = true;
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    programs.appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override {
        extraPkgs = pkgs: with pkgs; [
          zstd
          libepoxy
        ];
      };
    };
    programs.nix-ld = {
      enable = true;
    };
    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    hardware = {
      graphics.enable = true;
      nvidia.open = false;
    };

    services.samba = {
      enable = true;
      securityType = "user";
      openFirewall = true;

      shares = {
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

    services.xserver.videoDrivers = [ "nvidia" ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

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

    time.timeZone = "Europe/Moscow";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };

    fonts.packages = with pkgs; [
      source-code-pro
      dejavu_fonts
      font-awesome
      nerd-fonts.zed-mono
      jetbrains-mono
    ];

    services.xserver.enable = true;

    services.displayManager.gdm.enable = true;
    services.displayManager.sessionPackages = [
      self.packages.${system}.myNiri
    ];
    services.desktopManager.gnome.enable = true;

    services.xserver.xkb = {
      layout = "us,ru";
      variant = "";
      options = "grp:alt_shift_toggle,caps:escape";
    };

    services.printing.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true; # if you want use JACK apps

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # services.xserver.libinput.enable = true; # touchpad support (enabled default in most dm)

    users.users.administrator = {
      isNormalUser = true;
      description = "Gosha";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.fish;
      packages = with pkgs; [
      ];
    };
    users.groups.administrator = {};

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = {
      inherit inputs;
    };
    home-manager.users.administrator = { pkgs, lib, ... }: {
        imports = [ ../../../home/administrator/default.nix ];

        _module.args.pkgs-unstable = import inputs.nixpkgs-unstable {
          system = pkgs.stdenv.hostPlatform.system;
          config.allowUnfree = true;
        };
    };

    programs.firefox.enable = true;
    programs.vim.enable = true;
    programs.vim.defaultEditor = true;
    programs.amnezia-vpn.enable = true;
    programs.fish.enable = true;

    # $ nix search wget
    environment.systemPackages = with pkgs; [
       wget
       vim
       git
       curl
       htop
       tree
       fuzzel
       alacritty
       fish
       nix-ld
       deja-dup
       strongswan
       networkmanager-strongswan
       networkmanager-l2tp
       networkmanagerapplet
       openssl
    ] ++ [
      pkgsUnstable.keepassxc
      pkgsUnstable.amnezia-vpn
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?
  };
}
