{ self, inputs, ... }: {
  flake.nixosModules.docker = { ... }:
  {
    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
