{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      core = {
        editor = "vim";
      };
      user = {
        name = "Georgiy";
        email = "metallerok@gmail.com";
      };
    };
  };
}