{
  description = "monta's dotfiles (home-manager standalone)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
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
    in
    {
      homeConfigurations.monta = mkHome "aarch64-darwin";
      homeConfigurations.monta-x86_64 = mkHome "x86_64-darwin";

      packages.aarch64-darwin.home-manager = home-manager.packages.aarch64-darwin.default;
      packages.x86_64-darwin.home-manager = home-manager.packages.x86_64-darwin.default;
    };
}
