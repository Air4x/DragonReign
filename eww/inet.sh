#!/usr/bin/env bash

WIRED_ICON="󰈁"
WIFI_ICON="󰖩"
NO_NET_ICON=""

DATA="$(nmcli -t -f TYPE,STATE  d)"

ETHERNET_STATE="$(echo $DATA | awk '{ print $1}' | awk -F ':' '{ print $2 }')"

WIFI_STATE="$(echo $DATA | awk '{ print $2 }' | awk -F ':' '{ print $2 }')"

if [[ $ETHERNET_STATE=="connected" ]]; then
    echo $WIRED_ICON
elif [[ $WIFI_STATE=="connected" ]]; then
    echo $WIFI_ICON
else
    echo $NO_NET_ICON
fi
