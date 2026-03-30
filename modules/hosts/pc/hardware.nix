{ self, inputs, ... }: {
  flake.nixosModules.hardware = { ... }:
  {
    hardware = {
      graphics.enable = true;
      nvidia = {
        open = false;
        modesetting.enable = true;
      };
    };

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}