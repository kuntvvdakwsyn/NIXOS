{
    description = "NixOs from Scratch";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
        system = "x86_64-linux";
        pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
        };
    in {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit pkgs-unstable; };
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager
                {
                   nixpkgs.config.allowUnfree = true;
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.nixa = import ./home.nix;
                        backupFileExtension = "backup";
                    };
                }
            ];
        };
    };
}
