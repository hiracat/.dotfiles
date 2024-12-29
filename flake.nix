{
  description = "hiracat's dotfiles flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    base16.url = "github:SenchoPens/base16.nix";
    tt-schemes = {
      url = "github:tinted-theming/schemes/b3273211d5d1510aee669083fc5a1e0e4b5e310c";
      flake = false;
    };
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... } @inputs:
    let
      settings = {
        system = "x86_64-linux";
        username = "forest";
      };

      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${settings.system};
      pkgs-stable = import inputs.nixpkgs-stable {
        config.allowUnfree = true;
        stable = inputs.nixpkgs-stable.legacyPackages.${settings.system};
        system = settings.system;

      };
    in
    {
      nixosConfigurations = {
        "nixos-desktop" = lib.nixosSystem {
          specialArgs = { inherit inputs pkgs-stable settings; };
          modules = [
            ./scripts/default.nix
            inputs.base16.nixosModule

            ./hosts/desktop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                backupFileExtension = "backup";
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs settings; };
                users.forest = {
                  imports = [
                    inputs.base16.homeManagerModule
                    ./hosts/desktop/home.nix
                  ];
                };
              };
            }
          ];
        };
      };

      nixosConfigurations = {
        "nixos-laptop" = lib.nixosSystem {
          specialArgs = { inherit inputs pkgs-stable settings; };
          modules = [
            ./scheme.nix
            ./scripts/default.nix
            ./hosts/laptop/configuration.nix
            inputs.base16.nixosModule
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs settings; };
                users.forest = {
                  imports = [
                    inputs.base16.homeManagerModule
                    ./hosts/laptop/home.nix
                  ];
                };
              };
            }
          ];
        };
      };

      nixosConfigurations = {
        "nixos-server" = lib.nixosSystem {
          specialArgs = { inherit inputs pkgs-stable settings; };
          modules = [
            ./scheme.nix
            ./scripts/default.nix
            ./hosts/server/configuration.nix
            inputs.base16.nixosModule
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs settings; };
                users.forest = {
                  imports = [
                    inputs.base16.homeManagerModule
                    ./hosts/server/home.nix
                  ];
                };
              };
            }
          ];
        };
      };
    };

}
