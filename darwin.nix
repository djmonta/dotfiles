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

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.2;
      autohide-time-modifier = 0.2;
      magnification = true;
      persistent-apps = [];
      showhidden = true;
      tilesize = 55;
      wvous-tr-corner = 4; # Desktop
      wvous-bl-corner = 2; # Mission Control
      wvous-br-corner = 3; # Application windows
    };
    finder = {
      AppleShowAllFiles = true;
      NewWindowTarget = "Home";
      ShowExternalHardDrivesOnDesktop = false;
      ShowMountedServersOnDesktop = false;
      ShowRemovableMediaOnDesktop = false;
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    menuExtraClock = {
      Show24Hour = true;
      ShowDayOfWeek = true;
    };
    screencapture.type = "png";
    NSGlobalDomain.AppleShowScrollBars = "WhenScrolling";
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    trackpad.Clicking = true;
    trackpad.TrackpadCornerSecondaryClick = 2;
    NSGlobalDomain."com.apple.trackpad.trackpadCornerClickBehavior" = 1;
    NSGlobalDomain."com.apple.trackpad.enableSecondaryClick" = true;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
    LaunchServices.LSQuarantine = false;
    CustomUserPreferences = {
      "com.apple.Safari" = {
        "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
        "IncludeDevelopMenu" = true;
        "WebKitDeveloperExtrasEnabledPreferenceKey" = true;
        "IncludeInternalDebugMenu" = true;
        "ShowFullURLInSmartSearchField" = true;
        "ShowStatusBar" = true;
        "AutoFillPasswords" = false;
      };
      "com.apple.desktopservices".DSDontWriteNetworkStores = true;
      "com.apple.print.PrintingPrefs"."Quit When Finished" = true;
    };
  };
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  # Not expressible via system.defaults (filesystem flag, not a plist).
  system.activationScripts.postActivation.text = ''
    if [ -d ${home}/Library ]; then
      chflags nohidden ${home}/Library
    fi
  '';
}
