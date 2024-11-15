{
  description = "hiracat's dotfiles flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";
    base16.url = "github:SenchoPens/base16.nix";
    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... } @inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      desktop = "nixos-desktop";

      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = import inputs.nixpkgs-stable {
        config.allowUnfree = true;
        stable = inputs.nixpkgs-stable.legacyPackages.${system};
        system = system;

      };


    in
    {
      nixosConfigurations = {
        ${desktop} = lib.nixosSystem {
          system = system;
          specialArgs = { inherit inputs pkgs-stable; };
          modules = [
            inputs.base16.nixosModule
            ./scheme.nix
            ./hosts/desktop/configuration.nix
            ./scripts/default.nix
          ];
        };
      };

      # nixosConfigurations = {
      #   ${systemSettings.laptopHostname} = lib.nixosSystem {
      #     system = systemSettings.system;
      #     specialArgs = { inherit inputs; };
      #     modules = [
      #       inputs.base16.nixosModule
      #       ./nixos/configuration.nix
      #       ./nixos/laptop-configuration.nix
      #       ./nixos/laptop-hardware-configuration.nix
      #       ./scripts/default.nix
      #       ./scheme.nix
      #       # import laptop hardware config when created
      #       home-manager.nixosModules.home-manager
      #       {
      #         home-manager.extraSpecialArgs = { inherit inputs; };
      #         home-manager.useGlobalPkgs = true;
      #         home-manager.useUserPackages = true;
      #         home-manager.backupFileExtension = "backup";
      #         home-manager.users.${userSettings.username} = {
      #           imports = [
      #             ./home-manager/home.nix
      #             ./scheme.nix
      #             inputs.base16.homeManagerModule
      #           ];
      #         };
      #       }
      #     ];
      #   };
      # };
    };
}
