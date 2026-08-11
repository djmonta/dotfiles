{
  config,
  pkgs,
  ...
}:
let
  # Repo is the live source, same as create_symlink.sh.
  # mkOutOfStoreSymlink keeps files editable without home-manager switch.
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  home.username = "monta";
  home.homeDirectory = "/Users/monta";
  home.stateVersion = "25.11";

  xdg.enable = true;

  home.file = {
    ".bash_profile".source = link ".bash_profile";
    ".bashrc".source = link ".bashrc";
    ".profile".source = link ".profile";
    ".vimrc".source = link ".vimrc";
    ".zshenv".source = link ".zshenv";
    ".gitignore".source = link ".config/git/.gitignore.default";
  };

  # Do not replace ~/.local/bin (Hermes etc. live there). Put repo scripts on PATH instead.
  home.sessionPath = [ "${dotfiles}/bin" ];

  xdg.configFile = {
    "env.sh".source = link ".config/env.sh";
    "alias.sh".source = link ".config/alias.sh";
    "zsh".source = link ".config/zsh";
    "git".source = link ".config/git";
    "brewfile".source = link ".config/brewfile";
    "nvim".source = link ".config/nvim";
    # ~/.config/nix already points at this repo dir; linking nix.conf here loops.
    "starship.toml".source = link ".config/starship.toml";
    "tmux".source = link ".config/tmux";
    "ghostty".source = link ".config/ghostty";
    "pet".source = link ".config/pet";
    "zabrze".source = link ".config/zabrze";
    "leader_key".source = link ".config/leader_key";
  };

  programs.home-manager.enable = true;

  # Starter CLI. Homebrew copies can coexist; Nix is usually first on PATH.
  home.packages = with pkgs; [
    ripgrep
    fzf
    gh
    neovim
    zoxide
    starship
  ];
}
