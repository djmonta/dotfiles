# Full nix-darwin profile (system defaults + homebrew).
# Homebrew-only: flake output monta-brew (see `make darwin-brew`).
{
  imports = [
    ./darwin/base.nix
    ./darwin/system.nix
    ./darwin/homebrew.nix
  ];
}
