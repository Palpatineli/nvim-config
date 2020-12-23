nnoremap <buffer> <F5> :w<CR>:!cython -X language_level=3 %<CR>:!gcc -shared -pthread -fPIC -fwrapv -O2 -Wall -fno-strict-aliasing -I/usr/include/python3.7 -o %<.so %<.c<CR>
