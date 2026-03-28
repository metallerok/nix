{ config, pkgs, pkgs-unstable, ... }: {
  imports = [
    ./packages.nix
    ./ghostty.nix
    ./alacritty.nix
    ./git.nix
    ./vim.nix
    ./fish.nix
    ./theme.nix
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };

  home.stateVersion = "25.11";
}
