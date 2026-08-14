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
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});

      mkHome =
        system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./home.nix ];
        };

      mkDarwin =
        { hostPlatform, profile ? "full" }:
        nix-darwin.lib.darwinSystem {
          modules =
            [
              { nixpkgs.hostPlatform = hostPlatform; }
            ]
            ++ (
              if profile == "full" then
                [ ./darwin.nix ]
              else
                [
                  ./darwin/base.nix
                  ./darwin/homebrew.nix
                ]
            )
            ++ nixpkgs.lib.optionals (profile == "full") [
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
      darwinConfigurations.monta-brew = mkDarwin {
        hostPlatform = "aarch64-darwin";
        profile = "brew";
      };
      darwinConfigurations.monta-x86_64 = mkDarwin { hostPlatform = "x86_64-darwin"; };
      darwinConfigurations.monta-x86_64-brew = mkDarwin {
        hostPlatform = "x86_64-darwin";
        profile = "brew";
      };

      homeConfigurations.monta = mkHome "aarch64-darwin";
      homeConfigurations.monta-x86_64 = mkHome "x86_64-darwin";

      packages = forAllSystems (pkgs: {
        home-manager = home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default;
        darwin-rebuild = nix-darwin.packages.${pkgs.stdenv.hostPlatform.system}.darwin-rebuild;
      });

      # Dotfiles tooling. Other projects use their own flake + direnv.
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nixfmt-rfc-style
            shellcheck
            git
          ];
        };
      });
    };
}
