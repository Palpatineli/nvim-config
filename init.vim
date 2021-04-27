" packages
" " bootstrap packadd somehow not working
let g:packer_path = expand('~/.local/share/nvim/site/pack/packer/opt/paq-nvim')
if empty(glob(g:packer_path.'/lua/paq-nvim.lua'))
    exec 'silent !mkdir -p '.g:packer_path
    exec '!git clone https://github.com/savq/paq-nvim.git '.g:packer_path
endif
exec 'set runtimepath^='.g:packer_path
" " initialize
lua require('plugins')

" general
set updatetime=100
set hidden
syntax enable
set autochdir " set working directory to file directory
set updatecount=0 " no swap files
set noswapfile
set nobackup
if has('win32') || has('win64')
    set directory=%TMP%
else
    set directory=/tmp " throw out the temp file
endif

" ui
set termguicolors
set background=light
set t_Co=256
set t_Sf=[3%p1%dm
set t_Sb=[4%p1%dm

if has('win32') || has('win64')
    set guifont=consolas:h8
else
    set guifont=Iosevka\ 9
    set printfont=Iosevka\ 9
endif
set smartcase " case insensitive search
set fdm=syntax " folding by syntax for general files
set gdefault " substitutions go global by default
set title " program title shows file name
set nonumber
set equalalways "set ruler
set list
set listchars=tab:<+  " highlight hard tab
set tags=tags;
runtime macros/matchit.vim  " turn on matchit
set go= " minial gui
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" tabs
set expandtab
set tabstop=4 " external hard tab steps 4 spaces
set softtabstop=4 " soft tabs as spaces
set shiftwidth=4 " backspace delete soft tabs
set backspace=indent,eol,start

" filetypes
au BufNewFile,BufRead *.md,*.txt set filetype=pandoc  " for vim-pandoc
au BufNewFile,BufRead *.csv,*.dat set filetype=csv  " for CSV files
au BufNewFile,BufRead *.qml set filetype=javascript  " for qtquick
au BufNewFile,BufRead *.g set filetype=antlr3  " for antlr
au BufNewFile,BufRead *.g4 set filetype=antlr4
au BufNewFile,BufRead *.ts set filetype=typescript  " for ts
au BufNewFile,BufRead *.ino set filetype=c  " for auduino
au BufNewFile,BufRead *.msc set filetype=mscgen

" mapping
let mapleader=';'
ca w!! w !sudo tee "%"
" " Move around between windows
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
" " " Move around in terminal
:tnoremap <c-h> <C-\><C-n><C-w>h
:tnoremap <c-j> <C-\><C-n><C-w>j
:tnoremap <c-k> <C-\><C-n><C-w>k
:tnoremap <c-l> <C-\><C-n><C-w>l
" " copy and paste into/from system clipboard
nnoremap <leader><v> <ESC>"+pa
vnoremap <leader><v> <ESC>"+pa
vnoremap <leader><c> "+y
" " replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//<Left>
" " Insert date time
iab <expr> dts strftime("%F %T")
noremap <leader>m :message<cr>
set inccommand=split  " previwe substitution
augroup LuaHighlight  " highlight yanked
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" ranbow
let g:rainbow_active = 1

let g:vsnip_snippet_dir = "~/.config/nvim/snippets"
" completion-nvim
let g:completion_enable_snippet = "vim-vsnip"
let g:completion_chain_complete_list = {
            \ 'default': [
            \   {'complete_items': ['lsp']},
            \   {'complete_items': ['buffers']},
            \   {'complete_items': ['snippet', 'path']}
            \ ]}
autocmd BufEnter * lua require'completion'.on_attach()
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'       : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'       : '<C-j>'
imap <expr> <C-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'    : '<C-j>'
smap <expr> <C-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'    : '<C-j>'
imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'

" nvim-bufferline
lua require'bufferline'.setup()
nnoremap <silent><leader>bj :BufferLineCycleNext<CR>
nnoremap <silent><leader>bk :BufferLineCyclePrev<CR>
nnoremap <silent><leader>bJ :BufferLineMoveNext<CR>
nnoremap <silent><leader>bK :BufferLineMovePrev<CR>
lua require('statusline')
