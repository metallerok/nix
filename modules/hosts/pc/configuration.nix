{ self, inputs, ... }: {
  flake.nixosModules.pcConfiguration = { pkgs, lib, ... }:
	let
      system = pkgs.stdenv.hostPlatform.system;
	in
  {
    _module.args.pkgs-unstable = import inputs.nixpkgs-unstable {
      system = pkgs.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };

    nixpkgs.config = {
      allowUnfree = true;
    };

    imports = [
      self.nixosModules.pcHardware
      self.nixosModules.niri
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.programs
      self.nixosModules.docker
      self.nixosModules.samba
      self.nixosModules.networking
      self.nixosModules.hardware
      self.nixosModules.locale
      self.nixosModules.fonts
      self.nixosModules.systemd
      self.nixosModules.sound
      self.nixosModules.home-manager
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

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


    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?
  };
}
