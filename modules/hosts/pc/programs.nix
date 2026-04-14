{ self, inputs, ... }: {
  flake.nixosModules.programs = { options, pkgs, pkgs-unstable, lib, ... }:
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
      isoimagewriter
      glib
      gparted
      glibc
      transmission_4-gtk
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
      libraries = options.programs.nix-ld.libraries.default ++ (
        with pkgs; [
          glib
          nspr
          nss
          dbus
          atk
          cups
          cairo
          gtk3
          pango
          libx11
          libxcomposite
          libxdamage
          libxext
          libxfixes
          libxrandr
          libgbm
          expat
          libxcb
          libxkbcommon
          alsa-lib
          libGL
        ]
      );
    };
  };
}