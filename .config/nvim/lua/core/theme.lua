local bgState = require("utils.background")

vim.keymap.set("n", "<C-b>", function()
  if vim.opt.background:get() == "dark" then
    vim.opt.background = "light"
    bgState.set("light")
    print("☀️ Modo claro ativado")
  else
    vim.opt.background = "dark"
    bgState.set("dark")
    print("🌙 Modo escuro ativado")
  end
end, { noremap = true, silent = true })
