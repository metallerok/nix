{ ... }: {
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
}