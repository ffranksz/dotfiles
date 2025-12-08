#!/bin/bash

# Franklin Souza
# @ffranksz
# Script interativo para gerenciamento do Flatpak

# Cores
B="\e[1;34m"; G="\e[1;32m"; R="\e[1;31m"; Y="\e[1;33m"; NC="\e[0m"

title() {
    echo -e "${B}========== $1 ==========${NC}"
}

filtrar_programas() {
    grep -Ev "org.freedesktop|org.gnome|org.kde|org.winehq|org.gtk|Platform|platform|BaseApp|Compat|Extension|ffmpeg|GStreamer"
}

listar_instalados() {
    title "Pacotes Instalados (Programas)"
    flatpak list --app --columns=application,name \
        | filtrar_programas \
        | sort \
        | fzf --prompt="Instalados > "
}

instalar_pacote() {
    title "Instalar Pacote"
    app_id=$(
        flatpak search "" --columns=application,name \
        | filtrar_programas \
        | sort \
        | fzf --prompt="Escolha para instalar > " \
        | awk '{print $1}'
    )
    [ -z "$app_id" ] && return
    flatpak install "$app_id"
}

remover_pacote() {
    title "Remover Pacote"
    app_id=$(
        flatpak list --app --columns=application,name \
        | filtrar_programas \
        | sort \
        | fzf --prompt="Escolha para remover > " \
        | awk '{print $1}'
    )
    [ -z "$app_id" ] && return
    flatpak uninstall "$app_id"
}

atualizar_pacotes() {
    title "Atualizar Pacotes"
    echo -e "${G}Verificando atualizações...${NC}"
    flatpak update
    echo
    read -p "Pressione ENTER para continuar..."
}

# MENU PRINCIPAL
while true; do
    clear
    echo -e "${B}====== Gerenciador Flatpak ======${NC}"
    echo -e "${G}1${NC}) Instalar pacote"
    echo -e "${G}2${NC}) Remover pacote"
    echo -e "${G}3${NC}) Listar instalados"
    echo -e "${G}4${NC}) Atualizar pacotes"
    echo -e "${G}0${NC}) Sair"
    echo
    read -rp "Escolha uma opção: " op

    case "$op" in
        1) instalar_pacote ;;
        2) remover_pacote ;;
        3) listar_instalados ;;
        4) atualizar_pacotes ;;
        0) break ;;
        *) echo -e "${R}Opção inválida!${NC}"; sleep 1 ;;
    esac
done
