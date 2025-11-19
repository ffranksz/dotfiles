#!/usr/bin/env bash
export LANG=C
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [ $(tty) = /dev/tty1 ]; then
      # wayland related
      export QT_QPA_PLATFORM=wayland
      export CLUTTER_BACKEND=wayland
      export MOZ_ENABLE_WAYLAND=1
      export ENABLE_VK_KHR_WAYLAND_SURFACE=1
      export VK_ICD_FILENAMES=/etc/vulkan/icd.d/radeon_icd.x86_64.json
      export VK_LAYER_PATH=/usr/share/vulkan/explicit_layer.d
      export SDL_VIDEODRIVER=wayland

      # keyboard related
      export XKB_DEFAULT_LAYOUT='br'
      export XKB_DEFAULT_VARIANT='abnt2'
      #clear && sway
     
elif [ "$(tty)" = "/dev/tty2" ]; then
      #clear && startx
      
elif [ "$(tty)" = "/dev/tty3" ]; then
      # wayland related
      #export QT_QPA_PLATFORM=wayland
      #export CLUTTER_BACKEND=wayland
      #export MOZ_ENABLE_WAYLAND=1
      #export VK_ICD_FILENAMES=/etc/vulkan/icd.d/radeon_icd.x86_64.json
      #export ENABLE_VK_KHR_WAYLAND_SURFACE=1
      #export VK_LAYER_PATH=/usr/share/vulkan/explicit_layer.d
      #export SDL_VIDEODRIVER=x11
      
      # keyboard related
      #export XKB_DEFAULT_LAYOUT='br'
      #export XKB_DEFAULT_VARIANT='abnt2'

      clear && exec Hyprland
fi
