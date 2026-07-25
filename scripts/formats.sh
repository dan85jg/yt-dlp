#!/data/data/com.termux/files/usr/bin/bash

show_formats() {

    clipboard_url

    yt-dlp -F "$url"

    read -p "Pulsa ENTER para continuar..."

}