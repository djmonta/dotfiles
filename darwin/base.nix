{
  config,
  ...
}:
let
  home = config.users.users.monta.home;
in
{
  # Determinate Nix owns the daemon and /etc/nix. Do not let nix-darwin take over.
  nix.enable = false;

  system.primaryUser = "monta";
  system.stateVersion = 6;

  users.users.monta.home = "/Users/monta";

  environment.darwinConfig = "${home}/dotfiles/flake.nix";

  # Needed so /etc/zshrc loads nix-darwin environment.
  programs.zsh.enable = true;
}
