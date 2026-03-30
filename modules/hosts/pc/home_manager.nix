{ self, inputs, ... }: {
  flake.nixosModules.home-manager = { pkgs, ... }:
  {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = {
      inherit inputs;
    };
    home-manager.users.administrator = { pkgs, lib, ... }: {
      imports = [ ../../../home/administrator/default.nix ];

      _module.args.pkgs-unstable = import inputs.nixpkgs-unstable {
        system = pkgs.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    };
  };
}