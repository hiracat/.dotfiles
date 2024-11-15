{ home-manager, config, inputs, ... }: {
  imports = [
    ../../scheme.nix
    ./hardware-configuration.nix
    ../../modules/nixos/appearance.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/ime.nix
    ../../modules/nixos/periferals.nix
    ../../modules/nixos/software.nix
    # ../../modules/nixos/hyprland.nix
    home-manager.nixosModules.home-manager
    {
      home-manager.extraSpecialArgs = {
        inherit inputs;
      };
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "backup";
      home-manager.users.${config.base.username} = {
        imports = [
          ./home.nix
          ../../scheme.nix
          inputs.base16.homeManagerModule
        ];
      };
    }
  ];

  base.hostname = "nixos-desktop";
  base.username = "forest";
}
