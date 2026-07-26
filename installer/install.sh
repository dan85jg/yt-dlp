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
echo "  ✓ Instalar o actualizar yt-dlp"
echo "  ✓ Copiar el proyecto"
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

mkdir -p "$HOME/YT-DLP"
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
git
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
# Instalar o actualizar yt-dlp
############################################

step "[3/6] Instalando/Actualizando yt-dlp..."

pip install -U yt-dlp

if command -v yt-dlp >/dev/null 2>&1; then
    echo "✓ yt-dlp listo."
else
    echo
    echo "❌ No fue posible instalar yt-dlp."
    exit 1
fi

############################################
# Copiar proyecto
############################################

step "[4/6] Copiando proyecto..."

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

mkdir -p "$HOME/YT-DLP"

cp -a "$PROJECT_DIR"/. "$HOME/YT-DLP/"

echo "✓ Proyecto copiado."

############################################
# Crear configuración
############################################

step "[5/6] Creando configuración..."

if [ ! -f "$HOME/.config/yt-dlp/config" ]; then

cat > "$HOME/.config/yt-dlp/config" << EOF
DOWNLOAD_DIR=\$HOME/storage/downloads
VIDEO_FORMAT=bv*+ba/b
AUDIO_FORMAT=mp3
LAST_UPDATE_CHECK=0
EOF

echo "✓ Configuración creada."

else

echo "✓ Configuración existente conservada."

fi
############################################
# Crear Widget
############################################

step "[6/6] Creando Widget..."

cat > "$HOME/.shortcuts/yt" << EOF
#!/data/data/com.termux/files/usr/bin/bash

bash \$HOME/YT-DLP/scripts/yt
EOF

chmod +x "$HOME/.shortcuts/yt"

echo "✓ Widget creado."

############################################
# Dar permisos
############################################

chmod +x "$HOME"/YT-DLP/scripts/*.sh
chmod +x "$HOME"/YT-DLP/scripts/yt

cat > "$PREFIX/bin/yt" << EOF
#!/data/data/com.termux/files/usr/bin/bash

bash \$HOME/YT-DLP/scripts/yt
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