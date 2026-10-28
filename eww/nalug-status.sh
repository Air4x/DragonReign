#!/usr/bin/env bash

WEBSITE_CODE="$(curl -s --head https://www.nalug.tech | head -1 | cut -d ' ' -f 2)"

NEXTCLOUD_CODE="$(curl -s --head https://cloud.nalug.tech | head -1 | cut -d ' ' -f 2)"

FLUXER_CODE="$(curl -s --head https://fluxer.nalug.tech | head -1 | cut -d ' ' -f 2)"


if [[ $WEBSITE_CODE == "200" ]]; then
    WEBSITE_STATUS="💚";
else
    WEBSITE_STATUS="❌";
fi

if [[ $NEXTCLOUD_CODE == "200" ]]; then
    NEXTCLOUD_STATUS="💚";
else
    NEXTCLOUD_STATUS="❌";
fi

if [[ $FLUXER_CODE == "200" ]]; then
    FLUXER_STATUS="💚";
else
    FLUXER_STATUS="❌";
fi

echo "{\"fluxer\":\"$FLUXER_STATUS\", \"website\":\"$WEBSITE_STATUS\", \"nextcloud\":\"$NEXTCLOUD_STATUS\"}"
