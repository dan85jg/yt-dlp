#!/data/data/com.termux/files/usr/bin/bash

get_latest_version() {

    git ls-remote --tags https://github.com/dan85jg/yt-dlp.git \
        | awk '{print $2}' \
        | sed 's|refs/tags/||' \
        | sort -V \
        | tail -n1

}

should_check_updates() {

    local now

    now=$(date +%s)

    if [ -z "$LAST_UPDATE_CHECK" ]; then
        return 0
    fi

    if [ $((now - LAST_UPDATE_CHECK)) -ge 86400 ]; then
        return 0
    fi

    return 1

}

check_updates() {

    echo
    echo "Comprobando actualizaciones..."

    load_config

    if ! should_check_updates; then
        return
    fi

    if ! command -v git >/dev/null 2>&1; then
        echo "⚠ Git no está instalado."
        return
    fi

    local latest

    latest=$(get_latest_version)

    if [ -z "$latest" ]; then
        echo "⚠ No fue posible comprobar actualizaciones."
        return
    fi

    save_last_check "$(date +%s)"

    if [ "$latest" != "v$VERSION" ]; then

        echo
        echo "═══════════════════════════════"
        echo " Nueva versión disponible"
        echo
        echo " Instalada : v$VERSION"
        echo " Disponible: $latest"
        echo "═══════════════════════════════"
        echo

        read -p "¿Deseas actualizar ahora? [S/n]: " answer

        case "$answer" in
            ""|S|s|SI|Si|si)

                update_program
            ;;

        esac

    else

        echo "✓ Estás usando la versión más reciente."

    fi

    echo

}