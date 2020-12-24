lua require('telescope-setting')
nnoremap <leader>f <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>g <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>B <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>e <cmd>lua require('telescope.builtin').quickfix()<cr>
nnoremap <leader>l <cmd>lua require('telescope.builtin').loclist()<cr>

nnoremap <leader>O <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>o <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
