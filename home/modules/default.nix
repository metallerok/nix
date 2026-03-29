{ inputs,  ... }:
{
  flake.homeModules = {
    alacritty = import ./programs/alacritty.nix;
    ghostty = import ./programs/ghostty.nix;
    vim = import ./programs/vim.nix;
    gruvbox-theme = import ./themes/gruvbox_theme.nix;
  };
}