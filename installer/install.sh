#!/data/data/com.termux/files/usr/bin/bash

############################################
#            YT-DLP Setup Wizard
############################################

clear

echo "========================================="
echo "         YT-DLP Setup Wizard"
echo "========================================="
echo

step() {
    echo
    echo "========================================="
    echo "$1"
    echo "========================================="
    echo
}

############################################
# Comprobar Termux
############################################

if [ ! -d "/data/data/com.termux" ]; then
    echo "❌ ERROR"
    echo
    echo "Este instalador solo funciona en Termux."
    exit 1
fi

echo "✓ Termux detectado"

############################################
# Preparar carpeta del Widget
############################################

mkdir -p "$HOME/.shortcuts"

echo "✓ Carpeta para Widget preparada"

############################################
# Confirmación
############################################

echo
echo "Este instalador realizará las siguientes acciones:"
echo
echo "  ✓ Instalar dependencias necesarias"
echo "  ✓ Instalar yt-dlp"
echo "  ✓ Copiar los scripts"
echo "  ✓ Crear la configuración"
echo "  ✓ Crear el widget"
echo "  ✓ Solicitar permisos de almacenamiento"
echo

read -p "¿Deseas continuar? [S/n]: " respuesta

case "$respuesta" in
    ""|S|s|SI|Si|si|Y|y|YES|Yes|yes)
        ;;
    *)
        echo
        echo "Instalación cancelada."
        exit 0
        ;;
esac

############################################
# Crear carpetas
############################################

step "[1/6] Creando carpetas..."

mkdir -p "$HOME/Scripts"
mkdir -p "$HOME/.config/yt-dlp"

echo "✓ Carpetas creadas."

############################################
# Instalar dependencias
############################################

step "[2/6] Instalando dependencias..."

pkg update -y

DEPENDENCIAS=(
python
ffmpeg
jq
figlet
toilet
termux-api
)

for paquete in "${DEPENDENCIAS[@]}"
do
    if pkg list-installed | grep -q "^${paquete}/"; then
        echo "✓ $paquete"
    else
        echo "Instalando $paquete..."
        pkg install -y "$paquete"
    fi
done

############################################
# Verificar yt-dlp
############################################

step "[3/6] Verificando yt-dlp..."

if command -v yt-dlp >/dev/null 2>&1; then
    echo "✓ yt-dlp"
else
    echo "Instalando yt-dlp..."
    pip install -U yt-dlp
fi

############################################
# Copiar scripts
############################################

step "[4/6] Copiando scripts..."

SCRIPT_DIR="$(cd "$(dirname "$0")/../scripts" && pwd)"

cp "$SCRIPT_DIR"/* "$HOME/Scripts/"

echo "✓ Scripts copiados."

############################################
# Crear configuración
############################################

step "[5/6] Creando configuración..."

cat > "$HOME/.config/yt-dlp/config" << EOF
DOWNLOAD_DIR=\$HOME/storage/downloads
VIDEO_FORMAT=bv*+ba/b
AUDIO_FORMAT=mp3
LAST_UPDATE_CHECK=0
EOF

echo "✓ Configuración creada."

############################################
# Crear Widget
############################################

step "[6/6] Creando Widget..."

cat > "$HOME/.shortcuts/yt" << EOF
#!/data/data/com.termux/files/usr/bin/bash

bash \$HOME/Scripts/yt
EOF

chmod +x "$HOME/.shortcuts/yt"

echo "✓ Widget creado."

############################################
# Dar permisos
############################################

chmod +x "$HOME"/Scripts/*.sh
chmod +x "$HOME"/Scripts/yt

cat > "$PREFIX/bin/yt" << EOF
#!/data/data/com.termux/files/usr/bin/bash

bash \$HOME/Scripts/yt
EOF

chmod +x "$PREFIX/bin/yt"

echo "✓ Permisos configurados."
echo "✓ Comando 'yt' instalado."

############################################
# Solicitar acceso al almacenamiento
############################################

step "Solicitando permisos de almacenamiento..."

termux-setup-storage

############################################
# Finalizar
############################################

clear

echo "========================================="
echo "      INSTALACIÓN COMPLETADA"
echo "========================================="
echo

echo "✓ YT-DLP fue instalado correctamente."
echo
echo "Comando disponible:"
echo
echo "    yt"
echo

echo "========================================="
echo "Funciones opcionales"
echo "========================================="
echo

if command -v termux-toast >/dev/null 2>&1; then
    echo "✓ Termux:API detectado."
else
    echo "⚠ Instala la aplicación Termux:API para habilitar:"
    echo "  • Notificaciones"
    echo "  • Vibración"
    echo
fi

echo "ℹ Si deseas ejecutar YT-DLP desde un widget del escritorio,"
echo "  instala la aplicación Termux:Widget."
echo

echo "¡Disfruta YT-DLP!"
echo