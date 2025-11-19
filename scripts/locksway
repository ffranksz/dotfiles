#!/bin/bash
# Limpeza automática ao sair
trap 'rm -f /tmp/screen.png /tmp/screen_blur.png; dunstctl set-paused false' EXIT

# Screenshot e blur
grim /tmp/screen.png
convert /tmp/screen.png -resize 20% -blur 0x8 -resize 500% /tmp/screen_blur.png

# Lock com tema Catppuccin Mocha
swaylock \
  --clock \
  --indicator \
  --indicator-radius 140 \
  --indicator-thickness 8 \
  --effect-blur 7x5 \
  --effect-vignette 0.5:0.5 \
  --fade-in 0.5 \
  --show-failed-attempts \
  --ring-color 89b4fa \
  --ring-ver-color f9e2af \
  --ring-wrong-color f38ba8 \
  --inside-color 1e1e2e \
  --inside-ver-color 1e1e2e \
  --inside-wrong-color 1e1e2e \
  --text-color cdd6f4 \
  --text-ver-color f9e2af \
  --text-wrong-color f38ba8 \
  --key-hl-color a6e3a1 \
  --line-color 00000000 \
  --separator-color 00000000 \
  --daemonize \
  --image /tmp/screen_blur.png

