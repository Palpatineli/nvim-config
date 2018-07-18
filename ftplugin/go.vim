set nolist
compiler go
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

nnoremap <buffer> <F5> :w<CR>:!go run %<CR>
nnoremap <buffer> <F6> :w<CR>:!env GOOS=linux GOARCH=arm GOARM=7 go build<CR>:!sshpass -p raspberry scp -oStrictHostKeyChecking=no $CURPROJECT pi@$RPI:~/runtime/<CR>
inoremap <buffer> <c-b> <c-x><c-o>
