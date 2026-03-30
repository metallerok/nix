{ self, inputs, ... }: {
  flake.nixosModules.fonts = { pkgs, ... }:
  {
    fonts.packages = with pkgs; [
      source-code-pro
      dejavu_fonts
      font-awesome
      nerd-fonts.zed-mono
      jetbrains-mono
    ];
  };
}