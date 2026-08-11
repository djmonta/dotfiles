{
  config,
  ...
}:
{
  # Determinate Nix owns the daemon and /etc/nix. Do not let nix-darwin take over.
  nix.enable = false;

  system.primaryUser = "monta";
  system.stateVersion = 6;

  users.users.monta.home = "/Users/monta";

  environment.darwinConfig = "${config.users.users.monta.home}/dotfiles/flake.nix";

  # Needed so /etc/zshrc loads nix-darwin environment.
  programs.zsh.enable = true;

  # Minimal slice of etc/init/osx/50-osx_settings.sh.
  # Leave Homebrew, keyboard remap, Safari, and Dock contents to later.
  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.2;
      autohide-time-modifier = 0.2;
      magnification = true;
      tilesize = 55;
      wvous-tr-corner = 4; # Desktop
      wvous-bl-corner = 2; # Mission Control
      wvous-br-corner = 3; # Application windows
    };
    finder = {
      AppleShowAllFiles = true;
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    trackpad.Clicking = true;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
  };
}
