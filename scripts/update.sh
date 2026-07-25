#!/data/data/com.termux/files/usr/bin/bash

update_program() {

    echo
    echo "Actualizando yt-dlp..."
    echo

    pip install -U yt-dlp

    termux-toast "✅ yt-dlp actualizado"

    read -p "Pulsa ENTER para continuar..."

}