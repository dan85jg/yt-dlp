#!/data/data/com.termux/files/usr/bin/bash

download_audio() {

    clipboard_url

    yt-dlp \
        -P "$DOWNLOAD_DIR" \
        -x \
        --audio-format "$AUDIO_FORMAT" \
        "$url"

    safe_vibrate
    safe_toast "✅ MP3 descargado"

    read -p "Pulsa ENTER para continuar..."

}