#!/usr/bin/env bash

# Franklin Souza
# @ffraanksz

# Verifica se os comandos necessários estão disponíveis
command -v checkupdates >/dev/null 2>&1 || { echo "checkupdates não encontrado!"; exit 1; }
command -v paru >/dev/null 2>&1 || { echo "paru não encontrado!"; exit 1; }

# Atualizações dos repositórios oficiais
repo_updates=$(checkupdates 2>/dev/null | sed '/^\s*$/d' | wc -l)

# Atualizações do AUR (remove o próprio paru se aparecer)
aur_updates=$(paru -Qua 2>/dev/null | grep -v "^paru " | sed '/^\s*$/d' | wc -l)

# Soma total
total_updates=$((repo_updates + aur_updates))

# Exibição final
if (( total_updates > 0 )); then
  echo "󰏗    $total_updates update(s):   $repo_updates |    AUR  $aur_updates"
else
  echo "󰏖    arch is updated !"
fi

