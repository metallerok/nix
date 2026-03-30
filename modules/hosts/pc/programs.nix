{ self, inputs, ... }: {
  flake.nixosModules.programs = { pkgs, pkgs-unstable, lib, ... }:
  {
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
      direnv
      gnumake
      fastfetch
      pv
    ] ++ [
      pkgs-unstable.keepassxc
      pkgs-unstable.amnezia-vpn
      pkgs-unstable.uv
    ];
  };
}