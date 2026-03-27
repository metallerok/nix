{ config, pkgs, pkgs-unstable, ... }: {
  imports = [
    ./packages.nix
    ./ghostty.nix
    ./alacritty.nix
    ./git.nix
    ./vim.nix
    ./fish.nix
  ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "gruvbox-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };
    iconTheme = {
      name = "oomox-gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
  };

  services.xsettingsd = {
    enable = true;
    settings = { "Net/ThemeName" = "gruvbox-dark"; };
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };

  home.stateVersion = "25.11";
}
