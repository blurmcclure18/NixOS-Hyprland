{
	description = "My First Flake";

	inputs = {
		# Stable Packages Branch
		nixpkgs.url = "nixpkgs/nixos-26.05";

		# Unstable Packages Branch
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";

			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-flatpak.url = "github:gmodena/nix-flatpak";

		nix-citizen.url = "github:LovingMelody/nix-citizen";
		nix-gaming.url = "github:fufexan/nix-gaming";
		nix-citizen.inputs.nix-gaming.follows = "nix-gaming";

		zen-browser = {
			url = "github:youwen5/zen-browser-flake";
			inputs = {
				nixpkgs.follows = "nixpkgs";
			};
		};

		plymouth-theme-omarchy = {
			url = "github:blurmcclure18/plymouth-theme-omarchy";
			flake = false;
		};
	};

	outputs = { home-manager, nixpkgs, nixpkgs-unstable, nix-flatpak, self, ...}@inputs:

	  let
		system = "x86_64-linux";
		lib = nixpkgs.lib;
		nix-flat = nix-flatpak.nixosModules.nix-flatpak;
		pkgs = nixpkgs.legacyPackages.${system};
		unstable = import nixpkgs-unstable {
			inherit system;
			config.allowUnfree = true;
		};
	  in {
		nixosConfigurations = {

			laptop-nixos = lib.nixosSystem {
				inherit system;
				specialArgs = {inherit inputs self unstable;};
				modules = [
					nix-flat
					./hosts/laptop/configuration.nix
					./hosts/laptop/hardware-configuration.nix
				];
			};

			home-nixos = lib.nixosSystem {
				inherit system;
				specialArgs = {inherit inputs self unstable;};
				modules = [
					nix-flat
					./hosts/home-desktop/configuration.nix 
					./hosts/home-desktop/hardware-configuration.nix
					];
			};
		};

		homeConfigurations = {
			alec = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./home.nix ];
				extraSpecialArgs = { inherit inputs unstable; };
			};
		};
	};
}
