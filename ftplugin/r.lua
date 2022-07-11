vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':w<CR> :!R CMD BATCH %<CR> :!mv %.Rout rout/<CR>', {})
