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

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    networking.networkmanager.enable = true;

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
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    users.users.administrator = {
      isNormalUser = true;
      description = "Gosha";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
      ];
    };

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.administrator = ../../../home/administrator/default.nix;

    programs.firefox.enable = true;
    programs.vim.enable = true;
    programs.vim.defaultEditor = true;

    nixpkgs.config.allowUnfree = true;

    # $ nix search wget
    environment.systemPackages = with pkgs; [
       wget
       vim
       git
       curl
       htop
       tree
       fuzzel
       swaylock
       alacritty
       pkgsUnstable.keepassxc
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
