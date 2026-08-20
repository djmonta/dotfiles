{
  ...
}:
{
  homebrew.enable = true;
  homebrew.onActivation.cleanup = "none"; # 重要: 既存を消さない
  homebrew.taps = [
    { name = "rcmdnk/file"; trusted = true; }
    { name = "argon/mas"; trusted = true; } # mas も tap 経由なら
  ];

  homebrew.brews = [
    "mas"
    { name = "rcmdnk/file/brew-file"; trusted = true; }
    "mackup"
  ];
  # Declarative casks (add gradually; Brewfile duplicates OK while cleanup=none).
  homebrew.casks = [
    "gpg-suite"
    "iterm2"
    "itsycal"
    "popclip"
    "leader-key"
  ];
}
