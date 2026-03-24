{ config, pkgs, ...}: {
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    wl-clipboard
    python3
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      env = {
          TERM = "xterm-256color";
      };
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

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };
}
