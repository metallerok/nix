{ self, inputs, pkgs, ... }: {

  flake.nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        pkgs-unstable = import inputs.nixpkgs-unstable {
          system = pkgs.stdenv.hostPlatform.system;
          config.allowUnfree = true;
        };
			};

	    modules = [
	      self.nixosModules.pcConfiguration
	    ];
	};
}

