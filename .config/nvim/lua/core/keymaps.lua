-----------------------------------------------------
--                     KEYMAPS                     --
-----------------------------------------------------
vim.g.mapleader = ' '
local map = vim.keymap.set

-- NERDTreePlugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Toggle Indent Blankline
vim.keymap.set(
  "n",
  "<leader>ib",
  "<cmd>IBLToggle<CR>",
  { desc = "Toggle Indent Blankline" }
)

-- Spell
vim.keymap.set("n", "<leader>s", toggle_spell, {
  desc = "Toggle spell checker",
})

-- Neogit Open
vim.keymap.set("n", "<C-k>", ":Neogit<CR>", { noremap = true, silent = true })

-- Save
map('n','<C-s>',':w<CR>')

-- Quit
map('n','q',':q<CR>')

-- Force Quit
map('n','<C-q>',':q!<CR>')

-- Undo (Ctrl+Z)
map('n','<C-z>','u')

-- Select All (Ctrl+A)
map('n','<C-a>','ggVG')

-- NERDTree Files Icons
map('n','<C-l>',':NvimTreeToggle<CR>', {silent = true})

-- Terminal
map('n','<leader>t',':vsplit term://zsh<CR>A')

-- Dupla linha
default_opts = { noremap=true, silent=true }
map('n','<C-d>',':t.<CR>',default_opts)

-- NERDTree Comentários
map('n','<C-/>','<Plug>NERDCommenterToggle')
map('x','<C-/>','<Plug>NERDCommenterToggle')

-- Telescope
map('n','<F5>',':Telescope<CR>', {silent = true })

-- VCoolor
map('n','<F6>',':VCoolor<CR>')

-- Carbon
map('n','<F7>',':CarbonNow<CR>', { silent = true })

-- Número e relativo
map('n','<F2>',':set invnumber<CR>')
map('n','<F3>',':set relativenumber!<CR>')

-- PlugInstall / PlugUpdate
vim.keymap.set("n", "<C-r>", ":PlugInstall<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-p>", ":PlugUpdate<CR>", { noremap = true, silent = true })

-- Mason
vim.keymap.set("n", "<C-m>", ":Mason<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", ":MasonUpdate<CR>", { noremap = true, silent = true })

-- Copy to clipboard (como cp)
vim.keymap.set('n', 'cp', '"+y', { noremap = true, silent = true })
vim.keymap.set('v', 'cp', '"+y', { noremap = true, silent = true })

-- Paste from system clipboard (c = "+p)
vim.keymap.set('n', 'c', '"+p', {noremap = true, silent = true})

-- Movimentar linhas
map('n','<S-Up>',':m-2<CR>')
map('n','<S-Down>',':m+1<CR>')
map('i','<S-Up>','<Esc>:m-2<CR>')
map('i','<S-Down>','<Esc>:m+1<CR>')
