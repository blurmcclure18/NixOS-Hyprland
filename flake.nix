{
	description = "My First Flake";

	inputs = {
		# Stable Packages Branch
		nixpkgs.url = "nixpkgs/nixos-25.05";

		# Unstable Packages Branch
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

		home-manager.url = "github:nix-community/home-manager/release-25.05";

		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ...}:
	  let
		system = "x86_64-linux";
		lib = nixpkgs.lib;
		pkgs = nixpkgs.legacyPackages.${system};
		unstable = import nixpkgs-unstable {
			inherit system;
			config.allowUnfree = true;
		};
	  in {
		nixosConfigurations = {
			test-nixos = lib.nixosSystem {
				inherit system;
				inherit unstable;
				modules = [./configuration.nix ];
			};
		};

		homeConfigurations = {
			alec = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				inherit unstable;
				modules = [ ./home.nix ];
			};
		};
	};
}
