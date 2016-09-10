#!/bin/bash

if ! pgrep -q Karabiner; then
  printf "\e[32mObtain accessibility for Karabiner AXNotifier\e[0m\n"
  sql="
    INSERT OR REPLACE INTO access
    VALUES('kTCCServiceAccessibility','org.pqrs.Karabiner-AXNotifier',0,1,0,NULL);
  "
  sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db "${sql}"
  open -a Karabiner.app
fi

# /Applications/Karabiner.app/Contents/Library/bin/karabiner export > karabiner.sh
# を事前にしておく
source $(dirname "${BASH_SOURCE}")/app/karabiner.sh