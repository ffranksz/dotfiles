#!/bin/bash

# Franklin Souza
# @ffranksz
# Script interativo para gerenciamento do Flatpak
# Com notificações gráficas e som ao concluir ações

# Cores
B="\e[1;34m"; G="\e[1;32m"; R="\e[1;31m"; Y="\e[1;33m"; NC="\e[0m"

# Funções utilitárias
title() {
    echo -e "${B}========== $1 ==========${NC}"
}

emitir_som() {
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null &
}

notificar() {
    notify-send -a "Gerenciador Flatpak" "$1" "$2"
    emitir_som
}

filtrar_programas() {
    grep -Ev "org.freedesktop|org.gnome|org.kde|org.winehq|org.gtk|Platform|platform|BaseApp|Compat|Extension|ffmpeg|GStreamer"
}

# Ações
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
    if [ $? -eq 0 ]; then
        notificar "Instalação concluída" "$app_id foi instalado com sucesso."
    else
        notify-send -a "Gerenciador Flatpak" "Erro na instalação" "Falha ao instalar $app_id."
    fi
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
    if [ $? -eq 0 ]; then
        notificar "Remoção concluída" "$app_id foi removido com sucesso."
    else
        notify-send -a "Gerenciador Flatpak" "Erro na remoção" "Falha ao remover $app_id."
    fi
}

atualizar_pacotes() {
    title "Atualizar Pacotes"
    echo -e "${G}Verificando atualizações...${NC}"

    flatpak update
    if [ $? -eq 0 ]; then
        notificar "Atualização concluída" "Todos os pacotes Flatpak estão atualizados."
    else
        notify-send -a "Gerenciador Flatpak" "Erro na atualização" "Ocorreu um problema durante a atualização."
    fi

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
