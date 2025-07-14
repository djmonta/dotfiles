#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title copy tab1 url
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ?

# Documentation:
# @raycast.author sachiko_miyamoto
# @raycast.authorURL https://raycast.com/sachiko_miyamoto

tell application "Zen Browser"
	activate
	
	# Wait until it is truly frontmost.
	repeat while not frontmost
		delay 0.1
	end repeat
end tell

tell application "System Events" to keystroke "1" using command down
delay 1
tell application "System Events" to keystroke "c" using {shift down, command down}
delay 1

# tell application "Slack"
# 	activate
# 	
# 	# Wait until it is truly frontmost.
# 	repeat while not frontmost
# 		delay 0.1
# 	end repeat
# end tell
# 
# tell application "System Events" to keystroke "v" using command down
# delay 1
