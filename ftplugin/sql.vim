packadd vim-dadbod 
packadd vim-dadbod-ui
packadd vim-dadbod-completion

let g:dbs = {
\ "MACS": "sqlserver://bos-dbrnd01:1433/MACS",
\ "MACS_PreProd": "sqlserver://bos-dbrnd01.acadian-asset.com:1433/MACS_PreProd"
\}

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
