The djmonta's dotfiles
========

## Overview

Personal config files. New machines use Nix + home-manager / nix-darwin.

## Installation

Run the installation command below in your terminal.

| Tools | The installation command |
|:-:|:-:|
| cURL | `bash -c "$(curl -fsSL dot.djmonta.me)"` |
| Wget | `bash -c "$(wget -qO - dot.djmonta.me)"` |

That downloads `etc/install`, which will:

1. Clone or update `~/dotfiles` (it will not `rm -rf` an existing clone)
2. Offer to install [Determinate Nix](https://install.determinate.systems/) if `nix` is missing
3. Run `make hm` (home-manager). Falls back to `make deploy` without Nix
4. With `init` appended, also run `make init` (Xcode / Homebrew / macOS defaults)

Already cloned:

```bash
cd ~/dotfiles
make darwin   # nix-darwin + home-manager
make hm       # home-manager only
```

## Languages / project shells

Global CLIs (`node`, `python3`, `uv`, `go`) come from `home.packages`.

Pin versions per project with a flake and direnv (nix-direnv is enabled):

```bash
# in a project
echo 'use flake' > .envrc
direnv allow
```

This repo itself uses `.envrc` + `devShells.default` (nixfmt, shellcheck).
