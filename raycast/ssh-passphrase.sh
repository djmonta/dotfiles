#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Type SSH or sudo secret in iTerm2
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔐
# @raycast.argument1 {"type":"dropdown","placeholder":"Passphrase","data":[{"title":"mw_user","value":"1"},{"title":"miyamoto","value":"2"}]}

# Documentation:
# @raycast.description Type a 1Password secret into an unchanged iTerm2 SSH or sudo prompt.

set -euo pipefail

fail() {
    printf '%s\n' "$1" >&2
    exit 1
}

dir="$(cd "$(dirname "$0")" && pwd)"
src="$dir/ssh-passphrase.swift"
ascript="$dir/ssh-passphrase-iterm.applescript"
cache="${HOME}/.cache/ssh-passphrase"
bin="$cache/ssh-passphrase"
scpt="$cache/iterm.scpt"
stamp="$cache/.stamp"

[[ -f "$src" && -f "$ascript" ]] || fail "ssh-passphrase sources are missing."

mkdir -p "$cache"

current="$(/usr/bin/shasum -a 256 "$src" "$ascript")"
if [[ ! -x "$bin" || ! -f "$scpt" || ! -f "$stamp" || "$(cat "$stamp")" != "$current" ]]; then
    [[ -x /usr/bin/swiftc && -x /usr/bin/osacompile ]] || fail "Xcode Command Line Tools are missing."
    tmpbin="$cache/ssh-passphrase.new.$$"
    tmpscpt="$cache/iterm.scpt.new.$$"
    cleanup() { rm -f "$tmpbin" "$tmpscpt"; }
    trap cleanup EXIT
    /usr/bin/swiftc -O -o "$tmpbin" "$src" || fail "Could not compile ssh-passphrase."
    /usr/bin/osacompile -o "$tmpscpt" "$ascript" || fail "Could not compile iTerm2 automation."
    mv -f "$tmpbin" "$bin"
    mv -f "$tmpscpt" "$scpt"
    printf '%s\n' "$current" > "$stamp"
    trap - EXIT
fi

export SSH_PASSPHRASE_SCPT="$scpt"
exec "$bin" "$@"
