# SSH passphrase from 1Password into iTerm2

`ssh-passphrase.swift` adds **Type SSH Passphrase in iTerm2** to Raycast Script
Commands. It runs locally on macOS and sends the value directly to an iTerm2
session using Apple Events. It does not use the clipboard or simulate keystrokes.
No changes to the bastion or destination server are needed.
The command uses Raycast's `silent` mode: the Raycast window closes and the
completion message appears as a HUD notification.

## Setup

1. Save the existing remote key's passphrase in a password field in 1Password.
   Importing an SSH key does not necessarily preserve its original passphrase;
   create a separate password field if needed. Do not select the private-key field.
2. Enable **Integrate with 1Password CLI** in 1Password's developer settings.
   This script uses Homebrew's `op` and Apple's Swift (Xcode Command Line Tools).
3. Copy each field's **secret reference** (`op://vault/item/field`), not its value.
   Save the first reference in `~/.config/ssh-passphrase/reference.txt` and the
   second in `~/.config/ssh-passphrase/reference2.txt`. Existing `reference.txt`
   configuration continues to work as **Key 1**.
4. Add this repository's `raycast` directory in Raycast's Script Commands settings.
   Assign **Type SSH Passphrase in iTerm2** a hotkey if desired.
5. In iTerm2, select the session waiting at an empty OpenSSH
   `Enter passphrase for key '…':` prompt, then invoke the Raycast command and
   choose **Key 1** or **Key 2** in its required argument dropdown.
   Allow macOS Automation access to iTerm2 for the requesting app when prompted.
   Accessibility permission is not needed by this implementation.
6. Approve 1Password authentication. Do not switch iTerm2 tabs/panes or type during
   authentication. The script enters the passphrase without a newline; return to
   iTerm2 and press Enter yourself.

Example local configuration (replace both example references):

```sh
mkdir -p ~/.config/ssh-passphrase
printf '%s\n' 'op://Private/Remote SSH 1/passphrase' > ~/.config/ssh-passphrase/reference.txt
printf '%s\n' 'op://Private/Remote SSH 2/passphrase' > ~/.config/ssh-passphrase/reference2.txt
```

The argument values are `1` and `2`. A missing or unknown argument is rejected;
there is no automatic fallback to another key. To rename the Raycast choices,
edit only the `title` fields in `@raycast.argument1` at the top of the script
(for example, `Work` and `Personal`); keep the `value` fields as `1` and `2`.
The [Raycast argument metadata](https://github.com/raycast/script-commands/blob/master/documentation/ARGUMENTS.md)
defines the dropdown labels and values.

## Input checks and limitations

- Before reading the secret, the script captures the current iTerm2 session ID
  and visible contents. The last nonblank line must match the standard English
  OpenSSH key-passphrase prompt. Wrapped or localized prompts are not supported.
- Immediately before sending, it checks that the current session ID and visible
  contents are unchanged. A mismatch aborts without typing. Retry from the prompt.
- These checks are guardrails, not proof that the remote process is SSH or that
  terminal echo is disabled. Use only at a known SSH passphrase prompt. A remote
  process could imitate it; process state can also change without visible output.
- The secret travels through an in-memory pipe and an Apple-event parameter.
  It is never embedded in script source, command arguments, files, or script
  output. iTerm2 and the remote receiving process necessarily receive the value.
- Control characters and empty fields are rejected. Spaces, quotes, backslashes,
  and Unicode are passed as data, not interpreted as script code.
- AppleScript support is deprecated by iTerm2 but remains available in the locally
  installed app. No iTerm2 Python API setup is required.
- First test with a dummy 1Password field at a disposable SSH passphrase prompt.
  After real use succeeds, delete the old Raycast Snippet and any earlier
  clipboard-history entries containing the passphrase.

References: [1Password CLI read](https://developer.1password.com/docs/cli/reference/commands/read/),
[iTerm2 AppleScript](https://iterm2.com/documentation-scripting.html).
