-- Themery setup (você já tem a tabela com themes e livePreview)
require("themery").setup({
  themes = { "gruvbox", "onedark", "monokai", "catppuccin", "moonfly", "nordic",
             "miasma", "evergarden", "kyotonight", "apprentice", "rose-pine-moon",
             "cyberdream", "kanagawa-paper", "sonokai", "chocolatier", "dracula",
             "dracula-soft" },
  livePreview = true,
  saveOnChange = true,
})

-- Carrega automaticamente o último tema salvo
pcall(function()
    require("theme")  -- Arquivo gerado pelo Themery
end)

-- Cria um comando wrapper (garante que existe mesmo que o plugin não tenha registrado ainda)
vim.api.nvim_create_user_command("OpenThemery", function()
  vim.cmd("Themery")
end, { nargs = 0 })

-- Mapeamento seguro: Ctrl+T abre o Themery (mapeado para o wrapper)
vim.keymap.set("n", "<C-t>", ":OpenThemery<CR>", { noremap = true, silent = true })

pcall(require, "background")  -- Carrega último dark/light
