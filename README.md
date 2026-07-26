# YT-DLP para Android

## Captura

![YT-DLP](screenshots/menu.jpeg)

Una interfaz interactiva para **yt-dlp** diseñada para **Termux** en Android.

## Características

- 📹 Descargar videos.
- 🎵 Descargar audio en MP3.
- 📋 Ver formatos disponibles.
- 🔄 Actualizar automáticamente la aplicación.
- 📱 Compatible con Termux.
- ⚡ Instalación automática.

---

## Requisitos

- Termux (se recomienda la versión de F-Droid)
- Conexión a Internet
- Termux:API (opcional, para usar el portapapeles, vibración y notificaciones)
- Termux:Widget (opcional, para ejecutar la aplicación desde un acceso directo)

---

# Instalación

## 1. Actualizar Termux

Antes de instalar la aplicación es recomendable actualizar todos los paquetes:

```bash
pkg update -y
pkg upgrade -y
```

## 2. Instalar Git

```bash
pkg install git -y
```

## 3. Clonar el repositorio

```bash
git clone https://github.com/dan85jg/yt-dlp.git
```

## 4. Entrar al proyecto

```bash
cd yt-dlp
```

## 5. Ejecutar el instalador

```bash
bash installer/install.sh
```

---

## Uso

Una vez instalada la aplicación, basta con ejecutar:

```bash
yt
```

Si tienes instalada la aplicación **Termux:Widget**, puedes crear un acceso directo y abrir YT-DLP directamente desde la pantalla de inicio.

---

## Estructura del proyecto

```text
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
├── VERSION
└── README.md
```

---

## Licencia

Proyecto de código abierto bajo licencia MIT.

---

## Créditos

Este proyecto fue desarrollado por Daniel Garrido.

Parte del desarrollo, pruebas y documentación se realizó con ayuda de inteligencia artificial.
