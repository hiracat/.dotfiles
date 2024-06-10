{
    description = "hiracat's dotfiles flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ...}:

    let
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.${systemSettings.system};

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
            term = "kitty";
            font = "JetBrainsMono Nerd";
            fontPkg = pkgs.nerdfonts;
        };

    in {
       nixosConfigurations = {
           nixos = lib.nixosSystem {
               system = systemSettings.system;
               modules = [ ./configuration.nix ];
               specialArgs = {
                   inherit userSettings;
                   inherit systemSettings;
               };
           };
       };

       homeConfigurations = {
           forest = home-manager.lib.homeManagerConfiguration {
               inherit pkgs;
               modules = [ ./home.nix ];
               extraSpecialArgs = {
                   inherit userSettings;
                   inherit systemSettings;
               };
           };
       };
    };
}
