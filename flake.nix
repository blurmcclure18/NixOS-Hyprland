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
			work-nixos = lib.nixosSystem {
				inherit system;
				specialArgs = {inherit unstable;};
				modules = [
					./hosts/work-desktop/configuration.nix 
					./hosts/work-desktop/hardware-configuration.nix
					];
			};

			laptop-nixos = lib.nixosSystem {
				inherit system;
				specialArgs = {inherit unstable;};
				modules = [
					./hosts/laptop/configuration.nix
					./hosts/laptop/hardware-configuration.nix
				];
			};
		};

		homeConfigurations = {
			alec = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./home.nix ];

				extraSpecialArgs = { inherit unstable; };
			};
		};
	};
}
