lua require'lspsaga'.init_lsp_saga()

nnoremap <silent> <leader>h <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent> <leader>g <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

nnoremap <silent> <leader>D <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <silent> <leader>r <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent><leader>ld <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
