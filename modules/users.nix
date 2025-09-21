{ config, lib, pkgs, ... }:

{
  users.users.administrator = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      tree
    ];
  };
}
