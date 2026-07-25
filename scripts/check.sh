#!/data/data/com.termux/files/usr/bin/bash

check_system() {

    echo "Verificando sistema..."
    echo

    if command -v yt-dlp >/dev/null 2>&1; then
        echo "✓ yt-dlp"
    else
        echo "✗ yt-dlp"
    fi

    if command -v ffmpeg >/dev/null 2>&1; then
        echo "✓ FFmpeg"
    else
        echo "✗ FFmpeg"
    fi

    if ping -c 1 google.com >/dev/null 2>&1; then
        echo "✓ Internet"
    else
        echo "✗ Sin Internet"
    fi

    echo
}