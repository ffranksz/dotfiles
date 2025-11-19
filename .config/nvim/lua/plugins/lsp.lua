vim.lsp.enable("pyright")

-- Enter para confirmar sugestão
vim.cmd [[inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"]]

-- Tab navega entre sugestões
vim.cmd [[inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"]]
vim.cmd [[inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]
