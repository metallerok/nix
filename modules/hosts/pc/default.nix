{ self, inputs, ... }: {

  flake.nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {};

	    modules = [
	      self.nixosModules.pcConfiguration
	    ];
	};
}

