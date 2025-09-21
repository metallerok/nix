{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "virtio" ];
    };

    displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
    };

    desktopManager.plasma6.enable = true;
  };

}
