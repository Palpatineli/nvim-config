vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', '', {noremap=true, silent=true, callback=function() vim.lsp.buf.formatting() end})
