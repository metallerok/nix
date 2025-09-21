{ config, lib, pkgs, ... }:

{
  services.xserver.xkb.options = "caps:escape";
}
