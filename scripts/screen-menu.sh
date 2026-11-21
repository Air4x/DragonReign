#!/usr/bin/env bash


# the command that will be run at the
# swaymsg -t output $OUTPUT mode $MODE


# Choose the output
OUTPUT=$(swaymsg -r -t get_outputs | jq -r '.[].name' | rofi -dmenu)

# Choose the mode from those supported by the output
MODE=$(swaymsg -r -t get_outputs | jq -r '.[].modes[] | .width, .height, .refresh' | pr -3 -a -t -s | awk '{print $1 "x" $2 "@" $3/1000 "Hz"}' | rofi -dmenu)

# Apply the mode
swaymsg output $OUTPUT mode $MODE && dunstify "$OUTPUT change" "Applied mode $MODE to output $OUTPUT"

