lua require('telescope-setting')

nnoremap <leader>f <cmd>lua require('telescope.builtin').git_files(require('telescope.themes').get_dropdown{previewer = false})<cr>
nnoremap <leader>B <cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>
nnoremap <leader>e <cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>
nnoremap <leader>l <cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>

nnoremap <leader>F <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>o <cmd>lua require('telescope.builtin').treesitter()<cr>
nnoremap <leader>a <cmd>lua require('telescope.builtin').live_grep{cwd=require'telescope-setting'.get_lsp_client().config.root_dir}<cr>
nnoremap <expr> <leader>A ':lua require("telescope.builtin").live_grep()<cr>\b' . expand('<cword>') . '\b'
