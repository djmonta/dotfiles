#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title VPN
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author sachiko_miyamoto
# @raycast.authorURL https://raycast.com/sachiko_miyamoto

scutil --nc list | grep "L2TP" | cut -d "\"" -f2 | xargs -I{} networksetup -connectpppoeservice "{}"

