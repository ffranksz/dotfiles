# Export bin
export PATH="${PATH}:${HOME}/.local/bin/"

# Man page for nvim
export MANPAGER="nvim +Man!"
#export MANPAGER="less"

# Export colors for TERM
export TERM='xterm-256color'

# Export default config starship
#export STARSHIP_CONFIG=~/.starship

# You may need to manually set your language environment
export LANG=en_US.UTF-8
#export LANG=pt_BR.UTF-8

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Applications/Editor
#export BROWSER="vimb"
export BROWSER="firefox"
export EDITOR="nvim"

# Cursor
export XCURSOR_THEME=Colloid-dark-cursors
export XCURSOR_SIZE=24

# VULKAN
VK_DRIVER_FILES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
