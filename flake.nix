{
  description = "hiracat's dotfiles flake";

  inputs = {
    catppuccin.url = "github:catppuccin/nix";

    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... } @inputs:
    let
      inherit (self) outputs;

      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
      pkgs-stable = import inputs.nixpkgs-stable {
        config.allowUnfree = true;
        stable = inputs.nixpkgs-stable.legacyPackages.${systemSettings.system};
        system = systemSettings.system;
      };

      systemSettings = {
        system = "x86_64-linux";
        hostname = "nixos";
        timezone = "America/New_York";
        locale = "en_US.UTF-8";
      };

      userSettings = {
        username = "forest";
        email = "hiracat@proton.me";
        editor = "nvim";
        terminal = "kitty";
        font = "JetBrainsMono Nerd Font";
        fontPkg = pkgs.nerdfonts;
      };

    in
    {
      nixosConfigurations = {
        ${systemSettings.hostname} = lib.nixosSystem {
          system = systemSettings.system;
          specialArgs = { inherit inputs systemSettings userSettings; };
          modules = [
            ./configuration.nix
            inputs.catppuccin.nixosModules.catppuccin
          ];
        };
      };

      homeConfigurations = {
        # FIXME replace with your username@hostname
        "${userSettings.username}@${systemSettings.hostname}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs systemSettings userSettings; };
          # useGlobalPkgs = true;
          # useUserPackages = true;
          # backupFileExtension = "backup";
          # > Our main home-manager configuration file <
          modules = [ ./home.nix ];
        };
      };
    };
}
