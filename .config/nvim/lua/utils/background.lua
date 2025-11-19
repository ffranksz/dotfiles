local M = {}

-- Lê último valor salvo
local ok, bg = pcall(dofile, vim.fn.stdpath("config") .. "/background_state.lua")
if ok and (bg == "dark" or bg == "light") then
    vim.opt.background = bg
end

-- Função para salvar
function M.set(bg)
    local file = io.open(vim.fn.stdpath("config") .. "/background_state.lua", "w")
    if file then
        file:write('return "' .. bg .. '"')
        file:close()
    end
end

return M
