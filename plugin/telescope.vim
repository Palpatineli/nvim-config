lua require('telescope-setting')
nnoremap <leader>f <cmd>lua require('telescope').extensions.fzf_writer.files()<cr>
nnoremap <leader>B <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>e <cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>
nnoremap <leader>l <cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>

nnoremap <leader>F <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>o <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>a <cmd>lua require('telescope').extensions.fzf_writer.staged_grep()<cr>
nnoremap <expr> <leader>A ':lua require("telescope").extensions.fzf_writer.staged_grep()<cr>\b' . expand('<cword>') . '\b'
