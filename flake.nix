{
    description = "first flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ...}:
        let
            systemSettings = {
                system = "x86_64-linux";
            };

            lib = nixpkgs.lib;
            pkgs = nixpkgs.legacyPackages.${systemSettings.system};
        in {

        nixosConfigurations = {
            nixos = lib.nixosSystem {
                system = systemSettings.system;
                modules = [ ./configuration.nix ];
            };
        };

        homeConfigurations = {
            forest = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./home.nix ];
            };
        };
    };
}
