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
    firefox-wayland
    # Development
    nodejs
    python3
  ];

  programs.niri = {
    enable = true;
    settings = {
      input = {
        keyboard.xkb.layout = "us";
        keyboard.xkb.options = "caps:escape";
      };

      outputs = {
        "eDP-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.0;
          };
        };
      };

      layout = {
        focus-ring = {
          width = 4;
          color = "#89b4fa";
        };
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66666; }
        ];
        default-column-width = { proportion = 0.5; };
        gaps = 8;
      };

      spawn-at-startup = [
        { command = [ "waybar" ]; }
      ];

      window-rules = [
        {
          matches = [
            { app-id = "Alacritty"; }
          ];
          open-maximized = true;
        }
      ];

      bindings = {
        "Mod+Return" = {
          spawn = [ "alacritty" ];
        };
        "Mod+D" = {
          spawn = [ "bemenu-run" ];
        };
        "Mod+Shift+Q" = {
          close-window = { };
        };
        "Mod+Q" = {
          quit-hotkey-overlay = { };
        };
      };
    };
  };

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
    userName = "Administrator";
    userEmail = "administrator@local";
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
}