-- Franklin Souza @ffranksz
-- My neovim config

-- ===========================
--       CORE
-- ===========================
require("core.options")
require("core.keymaps")
require("core.plugins")
require("core.theme")

-- ===========================
--       PLUGINS CONFIG
-- ===========================
require("plugins.lualine")
require("plugins.bufferline")
require("plugins.colorizer")
require("plugins.beacon")
require("plugins.treesitter")
require("plugins.themery")
require("plugins.carbon")
require("plugins.dashboard")
require("plugins.minimap")
require("plugins.better-comments")
require("plugins.mason")
require("plugins.lsp")

-- Utils
pcall(require, "utils.background")
