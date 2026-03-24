{ config, pkgs, pkgs-unstable, ...}: {
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    wl-clipboard
    python3
    zed-editor
    pgadmin4-desktopmode
    obsidian
    zellij
  ] ++ [
      pkgs-unstable.opencode
  ];

  programs.alacritty = {
    enable = true;
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
}
