#!/usr/bin/env bash

# Franklin Souza
# @ffranksz
# Um script para descompactar arquivos Proton-GE na pasta correta

DOWNLOADS="$HOME/Downloads"
DEST="$HOME/.steam/steam/compatibilitytools.d"

mkdir -p "$DEST"

cd "$DOWNLOADS" || exit 1

FILE=$(ls GE-Proton*.tar.gz 2>/dev/null | fzf)

[ -z "$FILE" ] && { echo "Nada selecionado."; exit 1; }

echo "Extraindo $FILE..."
tar xf "$FILE" -C "$DEST"
echo "Concluído."
