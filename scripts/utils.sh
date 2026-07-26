#!/data/data/com.termux/files/usr/bin/bash

CONFIG="$HOME/.config/yt-dlp/config"
HISTORY="$HOME/.config/yt-dlp/history.txt"

if [ -f "$CONFIG" ]; then
    source "$CONFIG"
fi

# Detectar una sola vez si la aplicación Termux:API está instalada
HAS_TERMUX_API=false

if pm list packages 2>/dev/null | grep -q "com.termux.api"; then
    HAS_TERMUX_API=true
fi

clipboard_url() {

    PORTAPAPELES=$(safe_clipboard_get)

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

# ---------- Funciones seguras de Termux:API ----------

has_termux_api() {
    $HAS_TERMUX_API
}

safe_clipboard_get() {
    if has_termux_api \
        && command -v timeout >/dev/null 2>&1 \
        && command -v termux-clipboard-get >/dev/null 2>&1; then
        timeout 2 termux-clipboard-get 2>/dev/null || true
    fi
}

safe_vibrate() {
    if has_termux_api \
        && command -v timeout >/dev/null 2>&1 \
        && command -v termux-vibrate >/dev/null 2>&1; then
        timeout 2 termux-vibrate 2>/dev/null || true
    fi
}

safe_toast() {
    if has_termux_api \
        && command -v timeout >/dev/null 2>&1 \
        && command -v termux-toast >/dev/null 2>&1; then
        timeout 2 termux-toast "$1" 2>/dev/null || true
    fi
}