#!/usr/bin/env bash

# Backup Steam Proton Games + rclone
# Franklin Souza

set -euo pipefail

# =============================
# CONFIG GLOBAL
# =============================

MAX_BACKUPS=10
REMOTE_NAME="gdrive"
BASE_REMOTE_PATH="BackupsGames"
BASE_LOCAL_PATH="$HOME/Franks/Games/BackupsGames"
STEAM_COMPAT="$HOME/.local/share/Steam/steamapps/compatdata"

# =============================
# FUNÇÃO GENÉRICA DE BACKUP
# =============================

perform_backup() {

    local GAME_NAME="$1"
    local SAVE_DIR="$2"

    BACKUP_BASE="$BASE_LOCAL_PATH/$GAME_NAME"
    DATE="$(date +'%Y-%m-%d_%H-%M-%S')"
    DEST="$BACKUP_BASE/$DATE"
    LOG_FILE="$BACKUP_BASE/rclone.log"

    echo "🔎 Verificando o save do $GAME_NAME..."

    if [[ ! -d "$SAVE_DIR" ]]; then
        echo "❌ Diretório não encontrado:"
        echo "$SAVE_DIR"
        return 1
    fi

    mkdir -p "$DEST"

    echo "💾 Copiando os arquivos..."
    cp -a "$SAVE_DIR/"* "$DEST/"

    # =============================
    # ROTAÇÃO LOCAL
    # =============================

    cd "$BACKUP_BASE"
    ls -1dt */ 2>/dev/null | tail -n +$((MAX_BACKUPS+1)) | xargs -r rm -rf

    # =============================
    # RCLONE CHECK
    # =============================

    if ! command -v rclone >/dev/null 2>&1; then
        echo "⚠️ rclone não instalado. Backup apenas local."
        return 0
    fi

    if ! rclone listremotes | grep -q "^${REMOTE_NAME}:"; then
        echo "⚠️ Remote '${REMOTE_NAME}' não configurado."
        return 0
    fi

    REMOTE_PATH="${REMOTE_NAME}:${BASE_REMOTE_PATH}/${GAME_NAME}"

    echo "☁️ Enviando para o GDrive..."

    rclone copy "$DEST" "$REMOTE_PATH/$DATE" \
        --transfers=2 \
        --checkers=4 \
        --tpslimit=5 \
        --tpslimit-burst=5 \
        --retries=10 \
        --low-level-retries=20 \
        --create-empty-src-dirs \
        --log-file="$LOG_FILE" \
        --log-level INFO

    # =============================
    # ROTAÇÃO REMOTA
    # =============================

    mapfile -t REMOTE_FOLDERS < <(
        rclone lsd "$REMOTE_PATH" | awk '{print $NF}' | sort -r
    )

    TOTAL=${#REMOTE_FOLDERS[@]}

    if (( TOTAL > MAX_BACKUPS )); then
        for (( i=MAX_BACKUPS; i<TOTAL; i++ )); do
            echo "🗑️ Removendo remoto: ${REMOTE_FOLDERS[$i]}"
            rclone purge "$REMOTE_PATH/${REMOTE_FOLDERS[$i]}"
        done
    fi

    echo "✅ Backup concluído do jogo $GAME_NAME"
}

# =============================
# BACKUP DS2
# =============================

backup_ds2() {

    local APPID="335300"
    local SAVE_DIR="$STEAM_COMPAT/$APPID/pfx/drive_c/users/steamuser/AppData/Roaming/DarkSoulsII"

    perform_backup "DS2" "$SAVE_DIR"
}

# =============================
# BACKUP AC BLACK FLAG
# =============================

backup_acbf() {

    local APPID="242050"
    local BASE_PATH="$STEAM_COMPAT/$APPID/pfx/drive_c/Program Files (x86)/Ubisoft/Ubisoft Game Launcher/savegames"

    # Detecta automaticamente UUID da Ubisoft
    local SAVE_DIR
    SAVE_DIR=$(find "$BASE_PATH" -type d -path "*/437" 2>/dev/null | head -n1 || true)

    if [[ -z "${SAVE_DIR:-}" ]]; then
        echo "❌ Save do AC Black Flag não encontrado."
        return 1
    fi

    perform_backup "ACBF" "$SAVE_DIR"
}

# =============================
# MENU
# =============================

clear
echo "=============================="
echo "   🎮 BACKUP DE JOGOS"
echo "=============================="
echo
echo "1) DS2"
echo "2) AC Black Flag"
echo "3) Sair"
echo
read -rp "Escolha uma opção: " opt

case "$opt" in
    1) backup_ds2 ;;
    2) backup_acbf ;;
    3) exit 0 ;;
    *) echo "Opção inválida." ;;
esac
