packadd vim-dadbod 
packadd vim-dadbod-ui
packadd vim-dadbod-completion

let g:dbs = {"aam-macs": "sqlserver://bos-dbrnd01.acadian-asset.com:1433"}

lua << EOF
require"compe".setup {
    source = {
        buffer = true,
        calc = true,
        dadbod = true,
    }
}
EOF

nnoremap <F3> <cmd>DBUIToggle<cr>
