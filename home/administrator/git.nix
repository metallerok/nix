{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Georgiy";
        email = "metallerok@gmail.com";
      };
    };
  };
}