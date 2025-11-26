require('nvim-tree').setup {
  disable_netrw = true,
  hijack_netrw = true,

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },

  filters = {
    dotfiles = false,
  },

  git = {
    enable = true,
    ignore = false,
  },

  view = {
    width = 30,
    side = "left",
  },
}
