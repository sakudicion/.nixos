{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

	hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
    	ash-pc = nixpkgs.lib.nixosSystem {
      		specialArgs = {inherit inputs;};
      		modules = [
        		./hosts/ash-pc/configuration.nix
      		];
    	};
  	};
  };
}
