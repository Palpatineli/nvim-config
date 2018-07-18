set foldmethod=syntax
setlocal cindent cino=j1,(0,ws,Ws
map <buffer> <F5> :wa<CR>:!clang % -o %< -Ofast -stdlib=libstdc++ -std=c++11 -pthread<CR>
