#!/bin/bash

LOCK=$(systemd-inhibit --list | grep -i -E "udisks|Disk Manager")

if [[ -z "$LOCK" ]]; then
    echo "✅ Nenhum inhibitor do udisks ativo."
    exit 0
else
    echo "⚠️ Inhibitor do udisks encontrado."
    echo "🔧 Reiniciando udisks2..."
    sudo systemctl restart udisks2
    sleep 2

    if systemd-inhibit --list | grep -qi udisks; then
        echo "❌ Lock ainda presente."
        exit 1
    else
        echo "✅ Lock removido com sucesso."
        exit 0
    fi
fi
