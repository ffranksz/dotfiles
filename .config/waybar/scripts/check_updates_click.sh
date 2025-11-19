#!/usr/bin/env bash

# Franklin Souza
# @ffranksz
# Script para exibir atualizações ao clicar no módulo do Waybar

echo "Atualizando repositórios..."
sudo pacman -Syy

echo
echo "Pacotes oficiais:"
pacman -Qu

echo
echo "Pacotes AUR:"
paru -Qua | grep -v "^paru "
