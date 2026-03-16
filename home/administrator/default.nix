{ config, pkgs, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # Basic utilities
    tree
    htop
    btop
    # Wayland utilities
    waybar
    wayland-protocols
    wayland-utils
    # Clipboard
    wl-clipboard
    # Terminal
    alacritty
    # File manager
    yazi
    # Browser
    firefox
    # Development
    nodejs
    python3
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 12.0;
        normal.family = "Source Code Pro";
      };
      window = {
        decorations = "none";
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Administrator";
        email = "administrator@local";
      };
    };
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # Niri-specific environment
      export MOZ_ENABLE_WAYLAND=1
      export QT_QPA_PLATFORM=wayland
      export SDL_VIDEODRIVER=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1

      # PATH additions
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };

  # Environment variables for Wayland
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}