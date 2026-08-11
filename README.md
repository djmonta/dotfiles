The djmonta's dotfiles
========

## Overview

Personal config files. New machines use Nix + home-manager to place them.

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
make hm
```
