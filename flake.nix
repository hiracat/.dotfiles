{
  description = "hiracat's dotfiles flake";
  inputs = {

    mesa-good.url = "github:nixos/nixpkgs?ref=599ddd2b79331c1e6153e1659bdaab65d62c4c82";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.darwin.follows = "";
    matugen = {
      url = "github:/InioX/Matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... } @inputs:
    let
      settings = {
        system = "x86_64-linux";
        username = "forest";
      };
      lib = nixpkgs.lib;
      pkgs-stable = import inputs.nixpkgs-stable {
        system = settings.system;
        config.allowUnfree = true;
      };
      mkHost = name: lib.nixosSystem {
        specialArgs = { inherit inputs pkgs-stable settings; };
        modules = [
          inputs.spicetify-nix.nixosModules.spicetify
          ./scripts/default.nix
          home-manager.nixosModules.home-manager
          inputs.agenix.nixosModules.default
          {
            environment.systemPackages = [
              inputs.agenix.packages.${settings.system}.default
            ];
          }
          (./hosts + "/${name}/configuration.nix")
          {
            home-manager = {
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs settings; };
              users.${settings.username} = {
                imports = [
                  inputs.agenix.homeManagerModules.default
                  (./hosts + "/${name}/home.nix")
                ];
              };
            };
          }
        ];
      };
    in

    {
      nixosConfigurations = {
        "nixos-desktop" = mkHost "desktop";
        "nixos-laptop" = mkHost "laptop";
        "nixos-server" = mkHost "server";
      };
    };
}
