#!/data/data/com.termux/files/usr/bin/bash

CONFIG_FILE="$HOME/.config/yt-dlp/config"

load_config() {

    if [ -f "$CONFIG_FILE" ]; then
        source "$CONFIG_FILE"
    fi

}

save_last_check() {

    sed -i \
        "s/^LAST_UPDATE_CHECK=.*/LAST_UPDATE_CHECK=$1/" \
        "$CONFIG_FILE"

}