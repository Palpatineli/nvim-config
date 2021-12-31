" speedup
let g:loaded_matchit           = 0
let g:loaded_logiPat           = 0
let g:loaded_tarPlugin         = 0
let g:loaded_gzip              = 0
let g:loaded_zipPlugin         = 0
let g:loaded_2html_plugin      = 0
let g:loaded_shada_plugin      = 0
let g:loaded_netrw             = 0
let g:loaded_netrwPlugin       = 0
let g:loaded_tutor_mode_plugin = 0
let g:loaded_remote_plugins    = 0

" general
set hidden
set autochdir " set working directory to file directory
set relativenumber
set noswapfile nobackup
set exrc secure  "allow local rc file but disallow autocmd, shell and write commands in local rc
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" ui
set termguicolors
set background=light
set guifont=Iosevka\ 9
set printfont=Iosevka\ 9
set gdefault " substitutions go global by default
set title " program title shows file name
set list listchars=tab:<+  " highlight hard tab
set completeopt=menuone,noselect
set shortmess+=c  " no message when completion is selected
set expandtab tabstop=4 shiftwidth=4
set inccommand=nosplit

" filetypes
au BufNewFile,BufRead *.md,*.txt set filetype=markdown
au BufNewFile,BufRead *.qml set filetype=javascript  " for qtquick
au BufNewFile,BufRead *.msc set filetype=mscgen

" mapping
let mapleader=';'
ca w!! w !sudo tee "%"
" " Move around between windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" " Move around in terminal
:tnoremap <c-h> <C-\><C-n><C-w>h
:tnoremap <c-j> <C-\><C-n><C-w>j
:tnoremap <c-k> <C-\><C-n><C-w>k
:tnoremap <c-l> <C-\><C-n><C-w>l
" " replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//<Left>
" " Insert date time
iab <expr> dts strftime("%F %T")
noremap <leader>m :message<cr>
" completion
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"

" extra highlighting
hi Comment guifg=#aabfc9 guibg=NONE gui=nocombine
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
highlight ColorColumn ctermbg=magenta guibg=Magenta
call matchadd('ColorColumn', '\%121v', 120)

" packages
" " bootstrap packadd somehow not working
let g:packer_path = expand('~/.local/share/nvim/site/pack/packer/start/packer.nvim')
if empty(glob(g:packer_path.'/lua/packer.lua'))
    exec 'silent !mkdir -p '.g:packer_path
    exec '!git clone https://github.com/wbthomason/packer.nvim '.g:packer_path
endif
lua require('plugins')
lua require('lsp')
