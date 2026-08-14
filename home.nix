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

  # Session env (EDITOR, LESS, FZF_*, PATH): .config/env.sh
  home.file = {
    ".profile".source = link ".profile";
    ".vimrc".source = link ".vimrc";
    ".zshenv".source = link ".zshenv";
    ".gitignore".source = link ".config/git/.gitignore.default";
  };

  xdg.configFile = {
    "env.sh".source = link ".config/env.sh";
    "alias.sh".source = link ".config/alias.sh";
    "zsh".source = link ".config/zsh";
    "brewfile".source = link ".config/brewfile";
    "nvim".source = link ".config/nvim";
    # ~/.config/nix already points at this repo dir; linking nix.conf here loops.
    # Live-editable; programs.starship.settings is unused on purpose.
    "starship.toml".source = link ".config/starship.toml";
    "tmux".source = link ".config/tmux";
    "ghostty".source = link ".config/ghostty";
    "leader_key".source = link ".config/leader_key";
    "karabiner/karabiner.json".source = link ".config/karabiner/karabiner.json";
    "git/repo.conf".source = link ".config/git/repo.conf";
    "git/.gittemplate".source = link ".config/git/.gittemplate";
    "git/.commit_help".source = link ".config/git/.commit_help";
    "home-manager/zsh-integrations.zsh".text = ''
      eval "$(starship init zsh)"
      eval "$(zoxide init zsh ${lib.escapeShellArgs config.programs.zoxide.options})"
      eval "$(direnv hook zsh)"
      eval "$(fzf --zsh)"
    '';
    # Nix store paths for zsh plugins — sourced from .config/zsh/plugins.zsh only.
    "home-manager/zsh-plugin-paths.zsh".text = let
      fshDir = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting";
    in ''
      export ZSH_COMPLETIONS_DIR="${pkgs.zsh-completions}/share/zsh/site-functions"
      export ZSH_FSH_DIR="${fshDir}"
      export ZSH_AUTOSUGGESTIONS="${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
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

  programs.fzf = {
    enable = true;
    enableZshIntegration = false;
    # FZF_DEFAULT_* live in .config/env.sh
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;
    package = pkgs.git;
    settings = {
      alias = {
        l = "log";
        lg = "log --graph";
        lk = "log --graph --topo-order --abbrev-commit --date=short --decorate --all --boundary --pretty=format:'%Cgreen%ad %Cred%h%Creset -%C(yellow)%d%Creset %s %Cblue[%cn]%Creset'";
        lo = "log --oneline";
        lp = "log --patch";
        lt = "log --topo-order";
        branch-list-merged = "!git branch --merged master | grep -v -E '(develop|origin|master)'";
        branch-delete-merged = "!git branch-list-merged | xargs git branch -d";
      };
      credential.helper = "osxkeychain";
      include.path = "${dotfiles}/.config/git/repo.conf";
    };
  };

  # Starter CLI + minimal global language runtimes.
  # Pin versions per project with a flake + .envrc (direnv), not anyenv.
  home.packages = with pkgs; [
    git
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
    ssh-copy-id
    zsh-autosuggestions
    zsh-completions
    zsh-fast-syntax-highlighting
  ];
}
