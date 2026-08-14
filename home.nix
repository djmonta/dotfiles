{
  config,
  lib,
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
    "git/repo.conf".source = link ".config/git/repo.conf";
    "git/.gittemplate".source = link ".config/git/.gittemplate";
    "git/.gitignore.default".source = link ".config/git/.gitignore.default";
    "brewfile".source = link ".config/brewfile";
    "nvim".source = link ".config/nvim";
    # ~/.config/nix already points at this repo dir; linking nix.conf here loops.
    # Live-editable; programs.starship.settings is unused on purpose.
    "starship.toml".source = link ".config/starship.toml";
    "tmux".source = link ".config/tmux";
    "ghostty".source = link ".config/ghostty";
    "leader_key".source = link ".config/leader_key";
    "karabiner/karabiner.json".source = link ".config/karabiner/karabiner.json";
    "home-manager/zsh-integrations.zsh".text = ''
      eval "$(starship init zsh)"
      eval "$(zoxide init zsh ${lib.escapeShellArgs config.programs.zoxide.options})"
      eval "$(direnv hook zsh)"
      eval "$(fzf --zsh)"
    '';
    "home-manager/zsh-autosuggestions.zsh".text = ''
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    '';
    "home-manager/zsh-completions.zsh".text = ''
      fpath=(${pkgs.zsh-completions}/share/zsh/site-functions $fpath)
    '';
  };

  programs.home-manager.enable = true;

  # ZDOTDIR is ~/.config/zsh (repo-managed). Do not let HM generate ~/.zshrc.
  programs.starship = {
    enable = true;
    enableZshIntegration = false;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = false;
    options = [ "--cmd" "cd" ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = false;
    nix-direnv.enable = true;
    silent = true;
    config.global.hide_env_diff = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableZshIntegration = false;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = false;
    defaultCommand = "rg --files --hidden --glob '!.git'";
    defaultOptions = [
      "--height"
      "50%"
      "--reverse"
      "--border"
      "--ansi"
    ];
  };

  programs.git = {
    enable = true;
    delta.enable = true;
    aliases = {
      l = "log";
      lg = "log --graph";
      lk = "log --graph --topo-order --abbrev-commit --date=short --decorate --all --boundary --pretty=format:'%Cgreen%ad %Cred%h%Creset -%C(yellow)%d%Creset %s %Cblue[%cn]%Creset'";
      lo = "log --oneline";
      lp = "log --patch";
      lt = "log --topo-order";
      branch-list-merged = "!git branch --merged master | grep -v -E '(develop|origin|master)'";
      branch-delete-merged = "!git branch-list-merged | xargs git branch -d";
    };
    extraConfig = {
      credential.helper = "osxkeychain";
      include.path = "~/.config/git/repo.conf";
    };
  };

  # Starter CLI + minimal global language runtimes.
  # Pin versions per project with a flake + .envrc (direnv), not anyenv.
  home.packages = with pkgs; [
    ripgrep
    gh
    neovim
    nodejs
    python3
    uv
    go
    delta
    wakatime-cli
    terminal-notifier
  ];
}
