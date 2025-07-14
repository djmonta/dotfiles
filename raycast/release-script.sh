#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title release script
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author sachiko_miyamoto
# @raycast.authorURL https://raycast.com/sachiko_miyamoto

#!/usr/bin/env bash

# open slack channel server
osascript <<'EOF'
tell application "System Events"
    open location "slack://channel?team=T025LBDQW&id=C9L3S34MD"
end tell
EOF

# open zen browser tab1
osascript <<'EOF'
tell application "Zen Browser"
	activate
	
	# Wait until it is truly frontmost.
	repeat while not frontmost
		delay 0.1
	end repeat
end tell

tell application "System Events" to keystroke "1" using command down
delay 1
EOF

# get no. from dialog
read -r -d '' applescriptCode <<'EOF'
   set dialogText to text returned of (display dialog "No.?" default answer "")
   return dialogText
EOF

dialogText=$(osascript -e "$applescriptCode");

echo -e "12時リリース対象を締め切ります。\\nNo.$dialogText をリリースします\\n" | pbcopy;

# paste no. to slack
osascript <<'EOF'
tell application "Slack"
	activate
	
	# Wait until it is truly frontmost.
	repeat while not frontmost
		delay 0.1
	end repeat
end tell
tell application "System Events" to keystroke "v" using command down
delay 1
EOF

# copy tab1 url
osascript <<'EOF'
tell application "Zen Browser"
	activate
	
	# Wait until it is truly frontmost.
	repeat while not frontmost
		delay 0.1
	end repeat
end tell

tell application "System Events" to keystroke "c" using {shift down, command down}
delay 1
EOF

# paste tab1 url to slack
osascript <<'EOF'
tell application "Slack"
	activate
	
	# Wait until it is truly frontmost.
	repeat while not frontmost
		delay 0.1
	end repeat
end tell
tell application "System Events" to keystroke "v" using command down
delay 1
EOF
