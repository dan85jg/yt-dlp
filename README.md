# YT-DLP

## Captura

![YT-DLP](screenshots/menu.jpeg)

Una interfaz interactiva para **yt-dlp** diseñada para **Termux** en Android.

## Características

- 📹 Descargar videos.
- 🎵 Descargar audio en MP3.
- 📋 Ver formatos disponibles.
- 🔄 Actualizar yt-dlp.
- 📱 Compatible con Termux.
- ⚡ Instalación automática.

## Requisitos

- Termux
- Termux:API (opcional, para notificaciones y vibración)
- Termux:Widget (opcional, para ejecutar desde un widget)

## Instalación

```bash
pkg install git

git clone https://github.com/dan85jg/yt-dlp.git

cd yt-dlp

chmod +x installer/install.sh

./installer/install.sh
```

## Uso

Después de instalar, ejecutar en la consala de Termux (si se instalo Termux:widget se puede agregar el acceso directo al celular y omitir este paso siempre):

```bash
yt
```

## Estructura del proyecto

```
yt-dlp/
├── installer/
│   └── install.sh
├── scripts/
│   ├── yt
│   ├── banner.sh
│   ├── check.sh
│   ├── download.sh
│   ├── audio.sh
│   ├── formats.sh
│   ├── update.sh
│   └── utils.sh
└── README.md
```

## Licencia

Proyecto de código abierto bajo licencia MIT.




**Este trabajo fue echo con ayuda de IA**
