set foldmethod=syntax
let g:neobugger_leader = '['
setlocal cindent cino=j1,(0,ws,Ws
map <buffer> <F5> :wa<CR>:!clang-7 % -o %< -Ofast -lstdc++ -std=c++17 -pthread<CR>
