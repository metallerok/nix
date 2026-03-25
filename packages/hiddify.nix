{ pkgs, ... }:
let
  appimage-run = pkgs.appimage-run.override {
    extraPkgs = p: with p; [ zstd libepoxy ];
  };
  src = pkgs.fetchurl {
    url = "https://github.com/hiddify/hiddify-app/releases/download/v4.1.1/Hiddify-Linux-x64-AppImage.AppImage";
    hash = "sha256:eb2bb6c08971b98e2d0a01fc5b647e29ba17b1661149cc9f97eda0e77bf5bdc3";
  };
in
pkgs.writeShellScriptBin "hiddify" ''
  exec ${appimage-run}/bin/appimage-run ${src} "$@"
''
