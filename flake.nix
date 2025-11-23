{
	description = "My First Flake";

	inputs = {
		# Stable Packages Branch
		nixpkgs.url = "nixpkgs/nixos-25.05";

		# Unstable Packages Branch
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

		home-manager.url = "github:nix-community/home-manager/release-25.05";

		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		nix-flatpak.url = "github:gmodena/nix-flatpak";

		nix-gaming.url = "github:fufexan/nix-gaming";

		zen-browser.url = "github:0xc000022070/zen-browser-flake";
		zen-browser.inputs.nixpkgs.follows = "nixpkgs";
		zen-browser.inputs.home-manager.follows = "home-manager";

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
				specialArgs = {inherit self unstable;};
				modules = [
					nix-flatpak.nixosModules.nix-flatpak
					./hosts/laptop/configuration.nix
					./hosts/laptop/hardware-configuration.nix
				];
			};

			home-nixos = lib.nixosSystem {
				inherit system;
				specialArgs = {inherit inputs self unstable;};
				modules = [
					./hosts/home-desktop/configuration.nix 
					./hosts/home-desktop/hardware-configuration.nix
					];
			};
			optiplex-nixos = lib.nixosSystem {
				inherit system;
				specialArgs = {inherit self unstable;};
				modules = [
					nix-flat
					./hosts/optiplex-desktop/configuration.nix 
					./hosts/optiplex-desktop/hardware-configuration.nix
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
