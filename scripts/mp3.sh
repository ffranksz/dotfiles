#!/bin/bash

set -e

MUSIC_DIR="$HOME/.Music"

# Verifica dependências
for cmd in yt-dlp ffmpeg; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "Erro: $cmd não está instalado."
        echo "sudo pacman -S yt-dlp ffmpeg"
        exit 1
    fi
done

# Cria pasta se não existir
mkdir -p "$MUSIC_DIR"

# Verifica URL
if [ -z "$1" ]; then
    read -rp "Cole a URL do vídeo: " URL
else
    URL="$1"
fi

yt-dlp \
    --cookies-from-browser firefox \
    -f bestaudio \
    --extract-audio \
    --audio-format mp3 \
    --audio-quality 0 \
    -o "$MUSIC_DIR/%(title)s.%(ext)s" \
    "$URL"

echo "Concluído → $MUSIC_DIR"
