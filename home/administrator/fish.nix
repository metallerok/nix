{ ... }: {
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