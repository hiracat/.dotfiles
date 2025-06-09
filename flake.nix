{
  description = "hiracat's dotfiles flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    base16.url = "github:SenchoPens/base16.nix";
    tt-schemes = {
      url = "github:tinted-theming/schemes/b3273211d5d1510aee669083fc5a1e0e4b5e310c";
      flake = false;
    };
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
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
          (./hosts + "/${name}/configuration.nix")
          inputs.base16.nixosModule
          home-manager.nixosModules.home-manager

          {
            home-manager = {
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs settings; };
              users.${settings.username} = {
                imports = [
                  inputs.base16.homeManagerModule
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
