#!/usr/bin/env bash

# Franklin Souza
# @ffrannksz

# Diretório para salvar os prints
screenshot_dir="$HOME/Pictures/Screenshots"
mkdir -p "$screenshot_dir"

# Nome do arquivo
screenshot_file="$screenshot_dir/screenshot-$(date +%Y%m%d%H%M%S).png"

# Seleciona uma área e tira o screenshot
area=$(slurp)
if [ -z "$area" ]; then
    dunstify -a 'Screenshoter' -t 3000 "Captura de tela cancelada"
    exit 1
fi

grim -g "$area" "$screenshot_file"

# Copia a imagem para o clipboard
wl-copy < "$screenshot_file"

# Usa o swappy para edição
swappy -f "$screenshot_file"

# Exibe notificação de sucesso
dunstify -a 'Screenshoter' -i "$screenshot_file" -u low "Imagem Salva" "Salva em $screenshot_dir\n$(basename "$screenshot_file")"
