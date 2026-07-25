#!/data/data/com.termux/files/usr/bin/bash

download_video() {

    clipboard_url

    clear
    banner

    echo "==========================="
    echo "Selecciona la calidad"
    echo "==========================="
    echo
    echo "1) 🏆 Mejor disponible"
    echo "2) 📺 1080p"
    echo "3) 📺 720p"
    echo "4) 📱 480p"
    echo "5) 📋 Ver formatos"
    echo

    read -p "Opción: " quality

    case "$quality" in

        1)
            yt-dlp -P "$DOWNLOAD_DIR" \
            -f "$VIDEO_FORMAT" \
            "$url"
        ;;

        2)
            yt-dlp -P "$DOWNLOAD_DIR" \
            -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" \
            "$url"
        ;;

        3)
            yt-dlp -P "$DOWNLOAD_DIR" \
            -f "bestvideo[height<=720]+bestaudio/best[height<=720]" \
            "$url"
        ;;

        4)
            yt-dlp -P "$DOWNLOAD_DIR" \
            -f "bestvideo[height<=480]+bestaudio/best[height<=480]" \
            "$url"
        ;;

        5)
            yt-dlp -F "$url"
            read -p "Pulsa ENTER para continuar..."
            return
        ;;

        *)
            echo
            echo "❌ Opción inválida."
            sleep 2
            return
        ;;

    esac

    termux-vibrate
    termux-toast "✅ Descarga finalizada"

    read -p "Pulsa ENTER para continuar..."

}