" packages
if has('win32') || has('win64')
    let g:config_path = expand('~/AppData/Local/nvim')
else
    let g:config_path = expand('~/.config/nvim')
endif
let g:dein#install_github_api_token='76b7fe6e8c790dfe4bee05322694a9125c7d0338'
let g:dein_dir = g:config_path.'/dein'
let g:dein_plugin_dir = g:config_path.'/dein_plugins'
if empty(glob(g:dein_dir.'/rplugin'))
    exec 'silent !mkdir -p '.g:dein_dir
    exec '!git clone git@github.com:Shougo/dein.vim '.g:dein_dir
endif
exec 'set runtimepath^='.g:dein_dir
if dein#load_state(g:dein_plugin_dir)
    call dein#begin(g:dein_plugin_dir)
    call dein#add(g:dein_dir)
    call dein#add('jalvesaq/vimcmdline', {'on_ft': ['python']})
    call dein#add('chrisbra/Colorizer')
    call dein#add('Shougo/denite.nvim')
    call dein#add('kmnk/denite-dirmark')
    call dein#add('Konfekt/FastFold')
    call dein#add('tpope/vim-fugitive')
    call dein#add('rhysd/vim-grammarous', {'on_ft': ['html', 'txt', 'pandoc']})
    call dein#add('sjl/gundo.vim')
    call dein#add('Yggdroot/indentLine')
    call dein#add('autozimu/LanguageClient-neovim', {'rev': 'next', 'build': 'bash install.sh',})
    call dein#add('ncm2/ncm2')
    call dein#add('ncm2/ncm2-bufword')
    call dein#add('ncm2/ncm2-path')
    call dein#add('ncm2/ncm2-neosnippet')
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('scrooloose/nerdcommenter')
    call dein#add('Vimjas/vim-python-pep8-indent', {'on_ft': ['python']})
    call dein#add('goldfeld/vim-seek')
    call dein#add('nightsense/snow.git')
    call dein#add('tmhedberg/SimpylFold', {'on_ft': ['python']})
    call dein#add('nvim-treesitter/nvim-treesitter', {'build': 'TSUpdate'})
    call dein#add('romgrk/nvim-treesitter-context')
    call dein#add('p00f/nvim-ts-rainbow')
    call dein#add('nvim-treesitter/nvim-treesitter-refactor')
    call dein#add('roxma/nvim-yarp')
    call dein#end()
    call dein#save_state()
endif

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
colorscheme snow
set t_Co=256
set t_Sf=[3%p1%dm
set t_Sb=[4%p1%dm

if has('win32') || has('win64')
    set guifont=consolas:h8
else
    set guifont=DejaVuSansMono\ NF\ 9
    set printfont=DejaVuSansMono\ NF\ 9
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
" " Toggle Error Window
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    cclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        copen
    endif
endfunction
function! ToggleLocations()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
    " Nothing was closed, open syntastic error location panel
        lopen
    endif
endfunction
noremap <leader>e :call ToggleErrors()<cr>
noremap <leader>l :call ToggleLocations()<cr>
noremap <leader>m :message<cr>
set inccommand=nosplit

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" " ncm2 snippet
let g:neosnippet#enable_completed_snippet = 1
inoremap <silent> <expr> <CR> ncm2_neosnippet#expand_or("\<CR>", 'n')
imap <C-i>     <Plug>(neosnippet_expand_or_jump)
smap <C-i>     <Plug>(neosnippet_expand_or_jump)
xmap <C-i>     <Plug>(neosnippet_expand_target)

autocmd BufNewFile,BufRead * TSContextEnable
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua require('treesitter')
