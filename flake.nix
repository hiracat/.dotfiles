{
  description = "hiracat's dotfiles flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";
    nix-colors.url = "github:misterio77/nix-colors";

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
        aliases = {
          ll = "ls -l";
          nv = "nvim";
          gc = ''f() { git  add . && git commit -m "$1" && git push}; f'';
          killn = "killn() { pid=$(pidof waybar) && kill $pid }";
        };
      };

    in
    {
      nixosConfigurations = {
        ${systemSettings.hostname} = lib.nixosSystem {
          system = systemSettings.system;
          specialArgs = { inherit inputs systemSettings userSettings; };
          modules = [
            ./nixos/configuration.nix
            ./scripts/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs systemSettings userSettings; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${userSettings.username} = {
                imports = [
                  ./home-manager/home.nix
                ];
              };
            }
          ];
        };
      };
    };
}
