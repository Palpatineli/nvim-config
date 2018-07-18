if !has('nvim')
    " -- for Syntastic --
    let g:syntastic_c_include_dirs = ['/usr/include/python2.7', '/usr/lib/python2.7/dist-packages/numpy/core/include/numpy']
    let g:syntastic_c_compiler_options = ' -std=c99'
endif

set cindent
noremap <F5> :w<CR>:!gcc -std=c99 -O3 % -o %<<CR>
noremap <F6> :w<CR>:Pyclewn<CR>:Cmapkeys<CR>
