{ self, inputs, ... }: {
  perSystem = { pkgs, lib, system, ... }: {
    packages.myNoctalia =
    let
      pkgsUnstable = import inputs.nixpkgs-unstable {
        inherit system;
      };
    in
    inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      package = lib.mkForce pkgsUnstable.noctalia-shell;
      settings = (
        builtins.fromJSON (builtins.readFile ./noctalia.json)
      ).settings;
    };
  };
}
