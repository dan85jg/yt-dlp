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
# Verificar Termux:API
############################################

if ! command -v termux-toast >/dev/null 2>&1; then
    echo
    echo "========================================="
    echo "❌ HACE FALTA LA APP TERMUX:API"
    echo
    echo "Instálala y vuelve a ejecutar este instalador."
    echo "========================================="
    exit 1
fi

echo "✓ Termux:API"

############################################
# Preparar carpeta del Widget
############################################

mkdir -p "$HOME/.shortcuts"

echo "✓ Carpeta para Widget preparada"

echo
echo "Todas las verificaciones fueron correctas."

read -p "Pulsa ENTER para continuar..."

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

step "[2/6] Verificando dependencias..."

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

############################################
# Dar permisos
############################################

chmod +x "$HOME"/Scripts/*.sh
chmod +x "$HOME"/Scripts/yt

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
echo "También puedes usar el widget de Android."
echo
echo "NOTA:"
echo "Si el widget no aparece, instala la aplicación"
echo "\"Termux:Widget\" y añádelo desde la pantalla de inicio."
echo