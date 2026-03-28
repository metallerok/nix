{ pkgs, pkgs-unstable, ... }:
let
  myHiddify = import ../../packages/hiddify.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    wl-clipboard
    python3
    pgadmin4-desktopmode
    obsidian
    zellij
    myHiddify
    # LSP
    nil
    nixd
    gruvbox-gtk-theme
    gruvbox-dark-icons-gtk
  ] ++ [
      pkgs-unstable.opencode
      pkgs-unstable.zed-editor
      pkgs-unstable.megasync
      pkgs-unstable.telegram-desktop
      pkgs-unstable.bruno
  ];

  home.file.".local/share/applications/hiddify.desktop" = {
    text = ''
      [Desktop Entry]
      Name=Hiddify
      Exec=hiddify
      Terminal=false
      Type=Application
      Icon=hiddify
      Categories=Network;
      StartupWMClass=app.hiddify.com
    '';
    force = true;
  };
}