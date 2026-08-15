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
  zshDir = "${dotfiles}/.config/zsh";
in
{
  home.username = "monta";
  home.homeDirectory = "/Users/monta";
  home.stateVersion = "25.11";

  xdg.enable = true;

  # Session env (EDITOR, LESS, PATH): .config/env.sh (sourced from programs.zsh.envExtra)
  home.file = {
    ".profile".source = link ".profile";
    ".vimrc".source = link ".vimrc";
    # .zshenv / ~/.config/zsh: programs.zsh (not OutOfStoreSymlink of whole dir)
    ".gitignore".source = link ".config/git/.gitignore.default";
  };

  xdg.configFile = {
    "env.sh".source = link ".config/env.sh";
    "alias.sh".source = link ".config/alias.sh";
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
    # Nix store paths for zsh plugins — sourced from plugins.zsh only.
    "home-manager/zsh-plugin-paths.zsh".text = let
      fshDir = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting";
    in ''
      export ZSH_COMPLETIONS_DIR="${pkgs.zsh-completions}/share/zsh/site-functions"
      export ZSH_FSH_DIR="${fshDir}"
      export ZSH_AUTOSUGGESTIONS="${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    '';
  };

  programs.home-manager.enable = true;

  # ZDOTDIR = ~/.config/zsh (HM-generated). Modular *.zsh stay in ${zshDir} (live).
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    defaultKeymap = "emacs";
    completionInit = ''
      autoload -Uz compinit && compinit -u -d "$XDG_CACHE_HOME/zsh/compdump"
    '';
    history = {
      path = "${config.xdg.stateHome}/zsh/history";
      size = 1000000;
      save = 1000000;
    };
    envExtra = ''
      # Hand-written session env (EDITOR, PATH, …)
      if [ -f "${config.xdg.configHome}/env.sh" ]; then
        # shellcheck source=/dev/null
        . "${config.xdg.configHome}/env.sh"
      fi

      typeset -U path PATH
      typeset -U fpath

      unset SUDO_PATH
      typeset -xT SUDO_PATH sudo_path
      typeset -U sudo_path
      sudo_path=({/usr/local,/usr,}/sbin(N-/))
      export SUDO_PATH

      typeset -U cdpath
      cdpath=($HOME{,/links}(N-/))
    '';
    initContent = lib.mkMerge [
      # Before compinit (was initExtraBeforeCompInit)
      (lib.mkOrder 550 ''
        DEFAULT_USER='monta'
        DIRCOLORS_SOLARIZED_ZSH_THEME='256dark'

        for f in ${zshDir}/plugins.zsh ${zshDir}/autoload.zsh; do
          # shellcheck disable=SC1090
          source "$f"
        done
      '')
      (lib.mkOrder 1000 ''
        if [[ ! -d "${config.xdg.stateHome}/zsh" ]]; then
          mkdir -m 700 "${config.xdg.stateHome}/zsh"
        fi

        LISTMAX=50
        if [[ $UID -eq 0 ]]; then
          unset HISTFILE
          SAVEHIST=0
        fi

        # Interactive sh configs (alias.sh, …). env.sh already loaded in envExtra.
        for f in "${config.xdg.configHome}"/*.sh; do
          [[ -f "$f" ]] || continue
          if [[ ! -f "$f".zwc ]] || [[ "$f" -nt "$f".zwc ]]; then
            zcompile "$f"
          fi
          # shellcheck disable=SC1090
          source "$f"
        done

        for f in bindkey.zsh setopt.zsh zinit.zsh zstyle.zsh zalias.zsh utils.zsh; do
          _z="${zshDir}/$f"
          if [[ ! -f "$_z".zwc ]] || [[ "$_z" -nt "$_z".zwc ]]; then
            zcompile "$_z"
          fi
          # shellcheck disable=SC1090
          source "$_z"
        done
        unset _z

        # iTerm2 marks / cwd reporting (starship owns PS1 → squelch prompt wrap)
        export ITERM2_SQUELCH_MARK=1
        if [[ -f "${zshDir}/iterm2_shell_integration.zsh" ]]; then
          # shellcheck disable=SC1090
          source "${zshDir}/iterm2_shell_integration.zsh"
        fi

        # After 256colorlib (zinit snippet)
        SPROMPT="''${COLOR_FG_D70000}もしかして: ''${COLOR_FG_0087FF}''${STYLE_LINE}%r%{''${reset_color}%} [y,n,a,e] -> "

        fpath=(/usr/local/share/zsh/functions(N-/) /usr/local/share/zsh/site-functions(N-/) $fpath)
        if (( $+commands[brew] )); then
          BREW_PREFIX=$(brew --prefix)
          fpath=($BREW_PREFIX/share/zsh/functions(N-/) $BREW_PREFIX/share/zsh/site-functions(N-/) $fpath)
        fi
        fpath=(${zshDir}/functions/Completion(N-/) $fpath)
      '')
    ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd" "cd" ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    silent = true;
    config.global.hide_env_diff = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --hidden --glob '!.git'";
    defaultOptions = [
      "--height"
      "50%"
      "--reverse"
      "--border"
      "--ansi"
    ];
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
    ripgrep
    gh
    neovim
    nodejs
    python3
    uv
    go
    coreutils
    wakatime-cli
    terminal-notifier
    ssh-copy-id
    zsh-autosuggestions
    zsh-completions
    zsh-fast-syntax-highlighting
  ];
}
