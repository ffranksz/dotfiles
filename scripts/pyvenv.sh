#!/usr/bin/env bash
# ==========================================================
# Franklin Souza
# @ffranksz
# ==========================================================

set -euo pipefail

# ---------- CONFIGURAÇÕES ----------
AMBIENTES_DIR="$HOME/.PythonAmbienteVirtual"
mkdir -p "$AMBIENTES_DIR"

# ---------- CORES ----------
VERDE="\e[32m"
VERMELHO="\e[31m"
AMARELO="\e[33m"
AZUL="\e[34m"
RESET="\e[0m"

# ---------- FUNÇÕES ----------
pausa() { read -rp "Pressione ENTER para continuar..."; }

msg() { echo -e "${AZUL}$1${RESET}"; }
ok() { echo -e "${VERDE}✔ $1${RESET}"; }
erro() { echo -e "${VERMELHO}✖ $1${RESET}"; }

# Detecta binário Python válido
detectar_python() {
    for cmd in python3 python; do
        if command -v "$cmd" &>/dev/null; then
            echo "$cmd"
            return
        fi
    done
    erro "Nenhum interpretador Python encontrado."
    exit 1
}

# Cria novo ambiente virtual
criar_ambiente() {
    clear
    msg "📦 Criar novo ambiente virtual"
    echo
    read -rp "Digite o nome do ambiente (sem espaços ou acentos): " nome
    [ -z "$nome" ] && erro "Nome inválido." && return
    local path="$AMBIENTES_DIR/$nome"

    if [ -d "$path" ]; then
        erro "Já existe um ambiente chamado '$nome'."
        return
    fi

    local py
    py=$(detectar_python)
    ok "Usando Python: $py"
    echo
    $py -m venv "$path" && ok "Ambiente criado em: $path"
    echo -e "\nPara ativar: ${AMARELO}source \"$path/bin/activate\"${RESET}"
    pausa
}

# Remove ambiente virtual
remover_ambiente() {
    clear
    msg "🗑️ Remover ambiente virtual"
    cd "$AMBIENTES_DIR" || exit

    local lista
    lista=$(ls -1d */ 2>/dev/null | sed 's:/$::') || true
    [ -z "$lista" ] && erro "Nenhum ambiente encontrado." && pausa && return

    local alvo
    alvo=$(echo "$lista" | fzf --prompt="Selecione o ambiente para remover: " --height=15 --border --ansi) || return
    [ -z "$alvo" ] && return

    read -rp "Tem certeza que deseja remover '$alvo'? (s/N): " confirm
    if [[ "$confirm" =~ ^[sS]$ ]]; then
        rm -rf "$AMBIENTES_DIR/$alvo"
        ok "Ambiente '$alvo' removido com sucesso."
    else
        msg "Remoção cancelada."
    fi
    pausa
}

# Lista ambientes
listar_ambientes() {
    clear
    msg "📂 Ambientes Virtuais Existentes"
    echo
    ls -1 "$AMBIENTES_DIR" 2>/dev/null || echo "(nenhum encontrado)"
    echo
    pausa
}

# ---------- MENU PRINCIPAL ----------
while true; do
    clear
    echo -e "${AZUL}🐍 Gerenciador de Ambientes Virtuais Python${RESET}"
    echo "Diretório: $AMBIENTES_DIR"
    echo
    echo "[1] Criar novo ambiente"
    echo "[2] Remover ambiente"
    echo "[3] Listar ambientes"
    echo "[4] Sair"
    echo
    read -rp "Escolha uma opção: " opcao

    case "$opcao" in
        1) criar_ambiente ;;
        2) remover_ambiente ;;
        3) listar_ambientes ;;
        4) clear; exit 0 ;;
        *) erro "Opção inválida."; pausa ;;
    esac
done

