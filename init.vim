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
set hidden
set autochdir " set working directory to file directory
set noswapfile
set nobackup
set exrc   " allow local rc fiel
set secure " disallow autocmd, shell and write commands in local rc
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

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
au BufNewFile,BufRead *.md,*.txt set filetype=markdown
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
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
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

" vsnip snippet
let g:vsnip_snippet_dir = "~/.config/nvim/snippets"
imap <expr> <C-n> vsnip#expandable() ? '<Plug>(vsnip-expand)' : (vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-n>')
smap <expr> <C-n> vsnip#expandable() ? '<Plug>(vsnip-expand)' : (vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-n>')
imap <expr> <C-p> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-p>'
smap <expr> <C-p> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-p>'

" completion-nvim
augroup completion
    autocmd!
    autocmd BufEnter * lua require'completion'.on_attach()
    autocmd FileType sql let g:completion_trigger_character = ['.', '"', '`', '[']
augroup END
let g:completion_enable_snippet = "vim-vsnip"
let g:completion_chain_complete_list = {
            \ 'default': [
            \   {'complete_items': ['lsp']},
            \   {'complete_items': ['buffers']},
            \   {'complete_items': ['snippet', 'path']},
            \ ],
            \ 'org': [
            \   {'mode': 'omni'}
            \ ],
            \ 'sql': [
            \   {'completion_items': ['vim-dadbod-completion']},
            \ ],
            \ }
autocmd BufEnter * lua require'completion'.on_attach()

" nvim-bufferline
lua require'bufferline'.setup()
nnoremap <silent><leader>bj :BufferLineCycleNext<CR>
nnoremap <silent><leader>bk :BufferLineCyclePrev<CR>
nnoremap <silent><leader>bJ :BufferLineMoveNext<CR>
nnoremap <silent><leader>bK :BufferLineMovePrev<CR>
lua require('statusline')

" dadbod
let g:dbs = {
            \    "aam-macs": "sqlserver://bos-dbrnd01:1433"
            \}

" indentline
" " not show characters just change background
highlight IndentOdd guifg=NONE guibg=NONE gui=nocombine
highlight IndentEven guifg=NONE guibg=#F0F0F0 gui=nocombine
let g:indent_blankline_char_highlight_list = ["IndentOdd", "IndentEven"]
let g:indent_blankline_space_char_highlight_list = ["IndentOdd", "IndentEven"]
let g:indent_blankline_char = " "
let g:indent_blankline_space_char = " "
let g:indent_blankline_show_trailing_blankline_indent = 0

" extra highlighting
hi Comment guifg=#aabfc9 guibg=NONE gui=nocombine
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" neogit
lua require('neogit').setup{}
lua require('diffview').setup{}
nnoremap <silent> <F3> :Neogit<cr>

" nabla
nnoremap <F5> <cmd>lua require("nabla").action()<cr>
