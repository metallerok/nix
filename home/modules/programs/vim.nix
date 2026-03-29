{ ... }: {
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
}