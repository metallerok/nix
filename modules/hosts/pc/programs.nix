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
      nettools
      bind
      meld
    ] ++ [
      pkgs-unstable.keepassxc
      pkgs-unstable.amnezia-vpn
      pkgs-unstable.uv
    ];

    programs.firefox.enable = true;
    programs.vim.enable = true;
    programs.vim.defaultEditor = true;
    programs.amnezia-vpn.enable = true;
    programs.fish.enable = true;

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
  };
}