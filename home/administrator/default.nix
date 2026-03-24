{ config, pkgs, pkgs-unstable, ...}:
let
  myHiddify = import ../../packages/hiddify.nix { inherit pkgs; };
in
{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    wl-clipboard
    python3
    pgadmin4-desktopmode
    obsidian
    zellij
    myHiddify
  ] ++ [
      pkgs-unstable.opencode
      pkgs-unstable.zed-editor
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
