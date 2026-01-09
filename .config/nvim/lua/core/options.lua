-----------------------------------------------------
--                   BASIC SETTINGS                --
-----------------------------------------------------
local opt = vim.opt
opt.number = true
opt.relativenumber = false
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 4
opt.cursorline = true
opt.mouse = 'a'
opt.termguicolors = true
opt.clipboard = 'unnamedplus'
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.splitright = true
opt.splitbelow = true
opt.encoding = 'utf-8'
opt.hidden = true
opt.autowrite = true
opt.swapfile = false
opt.guifont = "JetBrainsMono Nerd Font:h12"

-- Speel
function _G.toggle_spell()
  vim.opt.spell = not vim.opt.spell:get()
  if vim.opt.spell:get() then
    vim.notify("Spell ON (pt_br)")
    vim.opt.spelllang = "pt_br"
  else
    vim.notify("Spell OFF")
  end
end
