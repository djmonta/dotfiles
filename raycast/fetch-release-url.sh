#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title fetch release url
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author sachiko_miyamoto
# @raycast.authorURL https://raycast.com/sachiko_miyamoto

DEPLOY_URL="https://script.google.com/macros/s/AKfycbygQ1qjF4Oh2hlzOXyBF0OWhLLb0BwfzP7U0M6QYzvg_7xIvNNaUaxBw8cOUGssoYQYfQ/exec"
RESULT=$(curl -L "$DEPLOY_URL")
echo "$RESULT" | pbcopy
echo "done"
