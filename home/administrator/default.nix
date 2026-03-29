{ config, pkgs, pkgs-unstable, inputs, ... }: {
  imports = [
    ./packages.nix
    ./git.nix
    ./fish.nix
    inputs.self.homeModules.ghostty
    inputs.self.homeModules.alacritty
    inputs.self.homeModules.vim
    inputs.self.homeModules.gruvbox-theme
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };

  home.stateVersion = "25.11";
}
