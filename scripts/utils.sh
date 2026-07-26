#!/data/data/com.termux/files/usr/bin/bash

CONFIG="$HOME/.config/yt-dlp/config"
HISTORY="$HOME/.config/yt-dlp/history.txt"

if [ -f "$CONFIG" ]; then
    source "$CONFIG"
fi

clipboard_url() {

    PORTAPAPELES=""

    if command -v timeout >/dev/null 2>&1; then
        PORTAPAPELES=$(timeout 2 termux-clipboard-get 2>/dev/null || true)
    fi

    if [[ "$PORTAPAPELES" =~ ^https?:// ]]; then
        echo
        echo "📋 URL encontrada:"
        echo "$PORTAPAPELES"
        echo

        read -p "¿Usarla? (S/n): " r

        if [[ "$r" == "" || "$r" == "s" || "$r" == "S" ]]; then
            url="$PORTAPAPELES"
        else
            read -p "Pega la URL: " url
        fi
    else
        read -p "Pega la URL: " url
    fi
}