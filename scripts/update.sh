#!/data/data/com.termux/files/usr/bin/bash

update_program() {

    echo
    echo "Actualizando YT-DLP..."
    echo

    cd "$HOME/YT-DLP" || return

    git pull

    bash installer/install.sh

}