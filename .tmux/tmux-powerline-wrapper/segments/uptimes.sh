#!/usr/bin/env sh
# Prints the uptime.

source "$TMUX_POWERLINE_WRAPPER_DIR/config.sh" || exit 1

# outstring = "22:24  up 3 days,  7:15, 2 users, load averages: 1.61 1.76 1.67"
outstring=$(${segments_path}/uptimes.sh)
upstring=$(echo "$outstring" | sed 's/, load averages: .*//' | sed 's/^.* up //')
uptime=$(echo "$upstring" | sed 's/\(.*\), .* users$/\1/')
echo "☝  $uptime"

# uptime=$(${segments_path}/uptime.sh)
# uptime=$(echo "$uptime" | sed 's/^[ \t]*//' | sed 's/[ \t]*$//')
# echo "☝  $uptime"

exit 0
