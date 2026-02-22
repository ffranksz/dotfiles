#!/usr/bin/env bash

# ==========================================
# Franklin Souza
# Gerenciador de Vídeos com yt-dlp + fzf
# ==========================================

set -euo pipefail

DESTINO="$HOME/.videos"
FAVORITOS="$DESTINO/favoritos"

# ===============================
# DEPENDÊNCIAS
# ===============================
deps=(yt-dlp fzf mpv find shuf)

for cmd in "${deps[@]}"; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "❌ Dependência ausente: $cmd"
        echo "Instale com: sudo pacman -S $cmd"
        exit 1
    fi
done

# ===============================
# PREPARAÇÃO DE DIRETÓRIOS
# ===============================
mkdir -p "$DESTINO"
mkdir -p "$FAVORITOS"

# ===============================
# FUNÇÕES
# ===============================

baixar_video() {
    clear
    read -rp "🔗 Cole a URL do vídeo: " URL

    [[ -z "$URL" ]] && { echo "❌ URL inválida."; sleep 1; return; }

    echo "⬇️  Baixando..."
    yt-dlp \
        -f "bestvideo+bestaudio/best" \
        --merge-output-format mp4 \
        --embed-metadata \
        --embed-thumbnail \
        --add-metadata \
        --write-description \
        --write-info-json \
        -o "$DESTINO/%(uploader)s/%(title)s.%(ext)s" \
        "$URL"

    echo "✅ Download concluído."
    read -rp "Pressione ENTER para continuar..."
}

listar_videos() {
    find "$DESTINO" -type f -iname "*.mp4" ! -path "$FAVORITOS/*"
}

assistir_video() {
    video=$(listar_videos | fzf --prompt="🎬 Selecione um vídeo: ")
    [[ -n "${video:-}" ]] && mpv "$video"
}

video_aleatorio() {
    video=$(listar_videos | shuf -n 1)
    [[ -n "${video:-}" ]] && mpv "$video"
}

salvar_favorito() {
    video=$(listar_videos | fzf --prompt="⭐ Escolha para favoritar: ")
    [[ -z "${video:-}" ]] && return

    ln -sf "$video" "$FAVORITOS/$(basename "$video")"
    echo "⭐ Adicionado aos favoritos."
    sleep 1
}

assistir_favoritos() {
    video=$(find "$FAVORITOS" -type f | fzf --prompt="📂 Favoritos: ")
    [[ -n "${video:-}" ]] && mpv "$video"
}

# ===============================
# MENU PRINCIPAL
# ===============================

while true; do
    opcao=$(printf "Baixar vídeos\nAssistir vídeos\nVer um vídeo aleatório\nSalvar nos favoritos\nAssistir vídeos favoritados\nSair" \
        | fzf --prompt="📌 Menu: ")

    case "$opcao" in
        "Baixar vídeos") baixar_video ;;
        "Assistir vídeos") assistir_video ;;
        "Ver um vídeo aleatório") video_aleatorio ;;
        "Salvar nos favoritos") salvar_favorito ;;
        "Assistir vídeos favoritados") assistir_favoritos ;;
        "Sair") exit 0 ;;
        *) exit 0 ;;
    esac
done
