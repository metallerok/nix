{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      core = {
        editor = "vim";
        merge.tool = "meld";
      };
      user = {
        name = "Georgiy";
        email = "metallerok@gmail.com";
      };
    };
  };
}