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
    call dein#add('akinsho/nvim-bufferline.lua')
    call dein#add('jalvesaq/vimcmdline', {'on_ft': ['python']})
    call dein#add('chrisbra/Colorizer')
    call dein#add('nvim-lua/completion-nvim')
    call dein#add('steelsojka/completion-buffers')
    call dein#add('Konfekt/FastFold')
    call dein#add('tpope/vim-fugitive')
    call dein#add('rhysd/vim-grammarous', {'on_ft': ['html', 'txt', 'pandoc']})
    call dein#add('sjl/gundo.vim')
    call dein#add('Yggdroot/indentLine')
    call dein#add('neovim/nvim-lspconfig')
    call dein#add('nvim-lua/lsp-status.nvim')
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('scrooloose/nerdcommenter')
    call dein#add('Vimjas/vim-python-pep8-indent', {'on_ft': ['python']})
    call dein#add('goldfeld/vim-seek')
    call dein#add('nightsense/snow.git')
    call dein#add('tmhedberg/SimpylFold', {'on_ft': ['python']})
    " " telescope and its support
    call dein#add('nvim-lua/popup.nvim')
    call dein#add('nvim-lua/plenary.nvim')
    call dein#add('nvim-telescope/telescope.nvim')
    call dein#add('kyazdani42/nvim-tree.lua')
    call dein#add('nvim-treesitter/nvim-treesitter', {'build': 'TSUpdate'})
    call dein#add('romgrk/nvim-treesitter-context')
    call dein#add('p00f/nvim-ts-rainbow')
    call dein#add('nvim-treesitter/nvim-treesitter-refactor')
    call dein#add('roxma/nvim-yarp')
    call dein#add('kyazdani42/nvim-web-devicons')
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
noremap <leader>m :message<cr>
set inccommand=nosplit

" completion-nvim
let g:completion_enable_snippet = "Neosnippet"
let g:completion_chain_complete_list = {
            \ 'default': [
            \   {'complete_items': ['lsp']},
            \   {'complete_items': ['buffers']},
            \   {'complete_items': ['snippet', 'path']}
            \ ]}
autocmd BufEnter * lua require'completion'.on_attach()

autocmd BufNewFile,BufRead * TSContextEnable
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua require('treesitter')
lua require('lsp')

" nvim-bufferline
lua require'bufferline'.setup()
nnoremap <silent><leader>bj :BufferLineCycleNext<CR>
nnoremap <silent><leader>bk :BufferLineCyclePrev<CR>
nnoremap <silent><leader>bJ :BufferLineMoveNext<CR>
nnoremap <silent><leader>bK :BufferLineMovePrev<CR>
