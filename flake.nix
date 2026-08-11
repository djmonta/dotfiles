{
  description = "monta's dotfiles (nix-darwin + home-manager)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    let
      mkHome =
        system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./home.nix ];
        };

      mkDarwin =
        { hostPlatform }:
        nix-darwin.lib.darwinSystem {
          modules = [
            ./darwin.nix
            { nixpkgs.hostPlatform = hostPlatform; }
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.users.monta = import ./home.nix;
            }
          ];
        };
    in
    {
      darwinConfigurations.monta = mkDarwin { hostPlatform = "aarch64-darwin"; };
      darwinConfigurations.monta-x86_64 = mkDarwin { hostPlatform = "x86_64-darwin"; };

      homeConfigurations.monta = mkHome "aarch64-darwin";
      homeConfigurations.monta-x86_64 = mkHome "x86_64-darwin";

      packages.aarch64-darwin = {
        home-manager = home-manager.packages.aarch64-darwin.default;
        darwin-rebuild = nix-darwin.packages.aarch64-darwin.darwin-rebuild;
      };
      packages.x86_64-darwin = {
        home-manager = home-manager.packages.x86_64-darwin.default;
        darwin-rebuild = nix-darwin.packages.x86_64-darwin.darwin-rebuild;
      };
    };
}
