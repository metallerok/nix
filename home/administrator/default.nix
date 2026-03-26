{ config, pkgs, pkgs-unstable, ... }:
let
  myHiddify = import ../../packages/hiddify.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    wl-clipboard
    python3
    pgadmin4-desktopmode
    obsidian
    zellij
    myHiddify
    # LSP
    nil
    nixd
  ] ++ [
      pkgs-unstable.opencode
      pkgs-unstable.zed-editor
      pkgs-unstable.megasync
  ];

  home.file.".local/share/applications/hiddify.desktop" = {
    text = ''
      [Desktop Entry]
      Name=Hiddify
      Exec=hiddify
      Terminal=false
      Type=Application
      Icon=hiddify
      Categories=Network;
      StartupWMClass=app.hiddify.com
    '';
    force = true;
  };

  programs.ghostty = {
    enable = true;
    settings = {
      term = "xterm-256color";
      theme = "gruvbox";
    };
    themes = {
      gruvbox = {
        background = "#1d2021";
        foreground = "#ebdbb2";
        selection-background = "#ebdbb2";
        selection-foreground = "#1d2021";
        cursor-color = "#ebdbb2";
        cursor-text = "#1d2021";
        palette = [
          "0=#1d2021"
          "1=#cc241d"
          "2=#98971a"
          "3=#d79921"
          "4=#458588"
          "5=#b16286"
          "6=#689d6a"
          "7=#a89984"
          "8=#928374"
          "9=#fb4934"
          "10=#b8bb26"
          "11=#fabd2f"
          "12=#83a598"
          "13=#d3869b"
          "14=#8ec07c"
          "15=#ebdbb2"
        ];
      };
    };
  };

  programs.alacritty = {
    enable = true;
    theme = "gruvbox_dark";
    settings = {
      env = {
          TERM = "xterm-256color";
      };
      font = {
        size = 13.0;
        normal.family = "JetBrains Mono";
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
        name = "Georgiy";
        email = "metallerok@gmail.com";
      };
    };
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      set shiftwidth=2
      set softtabstop=2
      set tabstop=2
      set expandtab
      set autoindent
      set smartindent
      set number
    '';
  };

  # programs.bash = {
  #   enable = true;
  #   bashrcExtra = ''
  #     export PATH="$HOME/.local/bin:$PATH"
  #   '';
  # };

  programs.fish = {
    enable = true;
    shellInit = ''
      fish_add_path ~/.local/bin
    '';
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -la";
      la = "ls -A";
    };
    plugins = [
      # { name = "autopair"; src = pkgs.fishPlugins.autopair; }
    ];
  };

  home.stateVersion = "25.11";
}
