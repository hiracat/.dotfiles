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
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
      scheme = "${inputs.tt-schemes}/base16/catppuccin-mocha.yaml";
      pkgs-stable = import inputs.nixpkgs-stable {
        config.allowUnfree = true;
        stable = inputs.nixpkgs-stable.legacyPackages.${systemSettings.system};
        system = systemSettings.system;
      };

      systemSettings = {
        system = "x86_64-linux";
        hostname = "nixos-desktop";
        laptopHostname = "nixos-laptop";
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
          nvim = "nvim $(fzf)";
          ff = "fastfetch";
        };
      };

    in
    {
      nixosConfigurations = {
        ${systemSettings.hostname} = lib.nixosSystem {
          system = systemSettings.system;
          specialArgs = { inherit inputs systemSettings userSettings; };
          modules = [
            inputs.base16.nixosModule
            { inherit scheme; }
            ./nixos/configuration.nix
            ./nixos/desktop-configuration.nix
            ./nixos/desktop-hardware-configuration.nix # here to easily manage many machines
            ./scripts/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs systemSettings userSettings;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${userSettings.username} = {
                imports = [
                  ./home-manager/home.nix
                  { inherit scheme; }
                  inputs.base16.homeManagerModule
                ];
              };
            }
          ];
        };
      };

      nixosConfigurations = {
        ${systemSettings.laptopHostname} = lib.nixosSystem {
          system = systemSettings.system;
          specialArgs = { inherit inputs systemSettings userSettings; };
          modules = [
            inputs.base16.nixosModule
            ./nixos/configuration.nix
            ./nixos/laptop-configuration.nix
            ./nixos/laptop-hardware-configuration.nix
            ./scripts/default.nix
            inputs.base16.nixosModule
            # import laptop hardware config when created
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs systemSettings userSettings; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${userSettings.username} = {
                imports = [
                  ./home-manager/home.nix
                  { inherit scheme; }
                  inputs.base16.homeManagerModule
                ];
              };
            }
          ];
        };
      };
    };
}
