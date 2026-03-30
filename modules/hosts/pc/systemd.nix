{ self, inputs, ... }: {
  flake.nixosModules.systemd = { ... }:
  {
    # disable hibernation
    powerManagement.enable = true;

    systemd = {
      targets = {
        sleep = {
          enable = false;
          unitConfig.DefaultDependencies = "no";
        };
        suspend = {
          enable = false;
          unitConfig.DefaultDependencies = "no";
        };
        hibernate = {
          enable = false;
          unitConfig.DefaultDependencies = "no";
        };
        "hybrid-sleep" = {
          enable = false;
          unitConfig.DefaultDependencies = "no";
        };
      };
    };
  };
}