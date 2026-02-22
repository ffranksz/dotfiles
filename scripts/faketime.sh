#!/usr/bin/env bash

# Dragon Age Inquisition - Time Skip Helper
# Uso: ./da_time_skip.sh 5   (avança 5 horas)

clear
set -e

if [[ -z "$1" ]]; then
    echo "Uso: $0 HORAS_PARA_AVANCAR"
    exit 1
fi

HORAS="$1"

if ! [[ "$HORAS" =~ ^[0-9]+$ ]]; then
    echo "Digite apenas número inteiro de horas."
    exit 1
fi

# Salva estado NTP
NTP_ATIVO=$(timedatectl show -p NTP --value)
DATA_REAL=$(date "+%Y-%m-%d %H:%M:%S")

restaurar() {
    echo "Restaurando horário real..."
    sudo timedatectl set-time "$DATA_REAL"
    sudo timedatectl set-ntp "$NTP_ATIVO"
    echo "Relógio restaurado."
}

trap restaurar EXIT

echo "Desativando NTP..."
sudo timedatectl set-ntp false

NOVA_DATA=$(date -d "+$HORAS hour" "+%Y-%m-%d %H:%M:%S")

echo "Avançando $HORAS hora(s)..."
sudo timedatectl set-time "$NOVA_DATA"

echo "Novo horário:"
date

echo
echo "Abra o jogo agora."
echo "Ao fechar o script (Ctrl+C), o horário será restaurado."
read -p "Pressione ENTER quando terminar no jogo..."
