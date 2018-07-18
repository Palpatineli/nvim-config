" Personal neovim config file of Keji Li
" { Set up dein as package manager
    if has('win32') || has('win64')
        let g:config_path = expand('~/AppData/Local/nvim')
    else
        let g:config_path = expand('~/.config/nvim')
    endif
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
        call dein#add('craigemery/vim-autotag')
        call dein#add('chrisbra/csv.vim', {'on_ft': ['csv', 'tsv']})
        call dein#add('Raimondi/delimitMate')
        call dein#add('wsdjeg/dein-ui.vim')
        call dein#add('Shougo/denite.nvim')
        call dein#add('neoclide/denite-git')
        call dein#add('Shougo/deoplete.nvim')
        call dein#add('Shougo/echodoc.vim')
        call dein#add('mattn/emmet-vim', {'on_ft': ['html', 'txt', 'pandoc']})
        call dein#add('Konfekt/FastFold')
        call dein#add('airblade/vim-gitgutter')
        call dein#add('tpope/vim-fugitive')
        call dein#add('jsfaint/gen_tags.vim')
        call dein#add('morhetz/gruvbox')
        call dein#add('sjl/gundo.vim')
        call dein#add('othree/html5.vim', {'on_ft': ['html', 'txt', 'pandoc']})
        call dein#add('Shougo/neosnippet.vim')
        call dein#add('Shougo/neosnippet-snippets')
        call dein#add('bfredl/nvim-ipy', {'on_ft': ['python']})
        "call dein#add('BurningEther/iron.nvim', {'on_ft': ['python']})  " in case nvim-ipy doesn't work
        call dein#add('pangloss/vim-javascript', {'on_ft': ['javascript', 'json']})
        call dein#add('lepture/vim-jinja', {'on_ft': ['html', 'jinja']})
        call dein#add('elzr/vim-json', {'on_ft': ['log', 'json']})
        call dein#add('udalov/kotlin-vim', {'on_ft': ['kotlin']})
        call dein#add('autozimu/LanguageClient-neovim', {'rev': 'next', 'build': 'bash install.sh', 'on_ft': ['c', 'cpp', 'rust', 'lua', 'r']})
        " { python specific to replace palantir's lsp
            call dein#add('w0rp/ale', {'on_ft': ['python', 'json', 'sql']})
            call dein#add('maximbaz/lightline-ale', {'on_ft': ['python', 'json', 'sql']})
            call dein#add('zchee/deoplete-jedi', {'on_ft': ['python']})
            call dein#add('davidhalter/jedi-vim', {'on_ft': ['python']})
        " }
        call dein#add('itchyny/lightline.vim')
        call dein#add('Palpatineli/lightline-lsc-nvim', {'on_ft': ['c', 'cpp', 'rust', 'lua']})
        call dein#add('embear/vim-localvimrc')
        call dein#add('lazywei/vim-matlab', {'on_ft': ['mat', 'matlab']})
        call dein#add('Shougo/neoyank.vim')
        call dein#add('scrooloose/nerdcommenter')
        call dein#add('moll/vim-node', {'on_ft': ['javascript']})
        call dein#add('vim-pandoc/vim-pandoc', {'on_ft': ['markdown', 'txt', 'pandoc']})
        call dein#add('vim-pandoc/vim-pandoc-syntax', {'on_ft': ['markdown', 'txt', 'pandoc']})
        call dein#add('vim-pandoc/vim-pandoc-after', {'on_ft': ['markdown', 'txt', 'pandoc']})
        " call dein#add('vyzyv/vimpyter', {'on_ft': ['ipynb'], 'build': {'linux': 'gksudo pip3 install notedown -U', 'windows': 'python3 -m pip install notedown -U'}})
        call dein#add('Vimjas/vim-python-pep8-indent', {'on_ft': ['python']})
        call dein#add('jalvesaq/Nvim-R', {'on_ft': ['r', 'rnoweb']})
        call dein#add('janko-m/vim-test')
        call dein#add('rust-lang/rust.vim', {'on_ft': ['rust']})
        call dein#add('goldfeld/vim-seek')
        call dein#add('tmhedberg/SimpylFold', {'on_ft': ['python']})
        call dein#add('cespare/vim-toml', {'on_ft': ['r', 'toml']})
        call dein#add('tomtom/tlib_vim')
        call dein#end()
        call dein#save_state()
    endif
    " Commands:
    " call dein#install()
    " call dein#update()
    " call dein#check_install()
    " call dein#check_update()
    " call dein#check_clean()
    " call dein#recache_runtimepath()
" }

" General {
    " get some autoload
    for f in split(glob(expand('~/.config/nvim/autoload/*.vim')), '\n')
        exe 'source' f
    endfor

    set termguicolors
    colorscheme gruvbox
    " dim inactive pane in tmux; not working
    "au FocusLost hi Normal guifg='#7c6f64' guibg='#ebdbb2'
    "au FocusGained hi Normal guifg='#3c3836' guibg='#fbf1c7'
    set background=light
    set t_Co=256
    set t_Sf=[3%p1%dm
    set t_Sb=[4%p1%dm

    filetype indent plugin on
    set updatetime=100
    syntax enable
    set autochdir " set working directory to file directory
    " Caching {
        set updatecount=0 " no swap files
        set noswapfile
        set nobackup
        if has('win32') || has('win64')
            set directory=%TMP%
        else
            set directory=/tmp " throw out the temp file
        endif
    " }
" }

" Vim UI {
    if has('win32') || has('win64')
        set guifont=consolas:h8
    else
        set guifont=DejaVuSansMono\ NF\ 9
        set printfont=DejaVuSansMono\ NF\ 9
    endif
    "if has('statusline')  " use lightline instead
        "set laststatus=2
        "set statusline=%<%f\  " filename
        "set statusline+=%w%h%m%r  " status info
        ""set statusline+=%{easygit#status()}  " git branch from fugitive
        "set statusline+=%#warningmsg#
        "set statusline+=\ [%{&ff}/%Y]  " filetype
        "set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " nagvigation
    "endif

    set smartcase " case insensitive search
    set fdm=syntax " folding by syntax for general files
    "set foldlevelstart=20 " starts with everything unfolded (because you have voom and ctags)
    set gdefault " substitutions go global by default
    set title " program title shows file name
    set nonumber
    set equalalways "set ruler
    set wildmenu " show list for completion
    set wildmode=list:longest " completion, list matches, then longest common part
    set wildignore+=*.o
    set wildignore+=*.so
    set wildignore+=*~
    set wildignore+=*.pyc
    set wildignore+=*/__pycache__/*
    set wildignore+=*/.git/*
    set wildignore+=*/.benchmarks/*
    set wildignore+=*/.mypy_cache/*
    set wildignore+=*/.pytest_cache/*
    set wildignore+=*/*.egg-info/*
    set list
    set listchars=tab:<+  " highlight hard tab
    set tags=tags;
    runtime macros/matchit.vim  " turn on matchit
    " GUI setting {
        set go= " minial GUI
        " set lines=40
    " }
" }

" Formatting {
    set expandtab
    set tabstop=4 " external hard tab steps 4 spaces
    set softtabstop=4 " soft tabs as spaces
    set shiftwidth=4 " backspace delete soft tabs
    set backspace=indent,eol,start
" }

" Additional Filetype Detection {
    " for vim-pandoc
    au BufNewFile,BufRead *.md,*.txt set filetype=pandoc
    "au BufNewFile,BufRead *.txt set ff=dos
    " for CSV files
    au BufNewFile,BufRead *.csv,*.dat set filetype=csv
    " for qtquick
    au BufNewFile,BufRead *.qml set filetype=javascript
    " for antlr
    au BufNewFile,BufRead *.g set filetype=antlr3
    au BufNewFile,BufRead *.g4 set filetype=antlr4
" }

"if has('nvim')
    ""force cursor change in gnome-terminal
    "let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1  # using this creates remnant
    "characters in guake although it works fine in gnome-ternimal
"endif

" General Settings
"{
    " Local Leader
    let mapleader=';'
    " refresh config
    nnoremap <leader><C-r> :so ~/.config/nvim/init.vim<cr>
    " force save
    ca w!! w !sudo tee "%"
    " PageUp & PageDown
    noremap <buffer> <Space> <C-d>
    noremap <buffer> <BS> <C-u>
    " Move around between windows
    noremap <c-j> <c-w>j
    noremap <c-k> <c-w>k
    noremap <c-h> <c-w>h
    noremap <c-l> <c-w>l
    :tnoremap <c-h> <C-\><C-n><C-w>h
    :tnoremap <c-j> <C-\><C-n><C-w>j
    :tnoremap <c-k> <C-\><C-n><C-w>k
    :tnoremap <c-l> <C-\><C-n><C-w>l
    " copy and paste into/from system clipboard
    nnoremap <leader><v> <ESC>"+pa
    vnoremap <leader><v> <ESC>"+pa
    vnoremap <leader><c> "+y
    " replace word under cursor
    nnoremap <Leader>s :%s/\<<C-r><C-w>\>//<Left>
    " Insert date time
    iab <expr> dts strftime("%F %T")
    " Toggle Semicolon at the end of line
    "{
        function! s:ToggleTrailingSemiColon()
          if getline('.') !~ ';$'
            let original_cursor_position = getpos('.')
            exec("s/$/;/")
            call setpos('.', original_cursor_position)
          else
           " Useful for Octave/Matlab
            let original_cursor_position = getpos('.')
            exec("s/;$//")
            call setpos('.', original_cursor_position)
          endif
        endfunction
        " For programming languages using a semi colon at the end of statement.
        autocmd FileType rust,c,cpp,css,java,javascript,perl,php,jade,octave,tex,matlab nmap <silent> <leader>; :call <SID>ToggleTrailingSemiColon()<CR>
        autocmd FileType rust,c,cpp,css,java,javascript,perl,php,jade,octave,tex,matlab inoremap <silent> ;; <ESC>:call <SID>ToggleTrailingSemiColon()<CR>
    "}
    " Toggle Error Window
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
    if has("nvim")
        set inccommand=nosplit
    endif
"}

" Plugin Specific
"{
    " -- vim-pandoc --
    "{
        let g:pandoc_no_empty_implicits = 1 " no implicit link to save speed in large files
        let g:pandoc_no_folding = 1 " leave folding to VOoM
        let g:pandoc_bibfiles = ['~/Dropbox/Paper/library.bib']
        let g:pandoc#modules#disabled = ['hypertext']
    "}
    " bibpdf
    "{
        set path+=~/Dropbox/Paper/comment  " comment folder to jump to
        set path+=~/Dropbox/wiki  " wiki folder to jump to
        set suffixesadd+=.txt
    "}
    " -- vim-seek --
    let g:seek_subst_disable = 1  " disable <s> for substitute so number<s> doesn't misfire
    " -- csv.vim -- automatically display as column
    "{
        aug CSV_Editing
            au!
            au BufRead,BufWritePost *.csv :%ArrangeColumn
            au BufWritePre *.csv :%UnArrangeColumn
        aug end
    "}
    " -- lightline --
    "{
        set noshowmode
        let g:lightline = {
          \ 'colorscheme': 'gruvbox',
          \ 'active': {
              \'left': [ [ 'mode', 'paste' ],
              \          [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
              \'right': [ [ 'lineinfo' ],
              \           [ 'percent' ],
              \           [ 'filetype'] ]
          \ },
          \ 'component_function': {
              \ 'filename': 'LightLineFilename',
              \ 'gitbranch': 'fugitive#head',
          \ }
        \ }
        function! LightLineFilename()
            let name = ""
            let subs = split(expand('%:p'), "/") 
            let i = 1
            for s in subs
                let parent = name
                if  i == len(subs)
                    let name = parent . '/' . s
                elseif i == 1
                    let name = s
                else
                    let name = parent . '/' . strpart(s, 0, 2)
                endif
                let i += 1
            endfor
            return name
        endfunction
    "}
    "{ ALE
    function! SetAleOptions()
        nnoremap <silent> <c-.> <Plug>(ale_next_wrap)
        nnoremap <silent> <c-,> <Plug>(ale_previsou_wrap)
        let g:ale_set_loclist = 0
        let g:ale_set_quickfix = 1
        let g:ale_open_list = 0
        let g:ale_list_window_size = 5
    "{ lightline-ale
        let g:lightline#ale#indicator_checking = "\ufbab"
        let g:lightline#ale#indicator_warnings = "\uf071"
        let g:lightline#ale#indicator_errors = "\uf05e"
        let g:lightline#ale#indicator_ok = "\uf00c"
        let g:lightline.active.right = [['linter_checking', 'linter_errors', 'linter_ok', 'linter_warnings']] + g:lightline.active.right
        let g:lightline.component_expand = {
        \  'linter_checking': 'lightline#ale#checking',
        \  'linter_errors': 'lightline#ale#errors',
        \  'linter_ok': 'lightline#ale#ok',
        \  'linter_warnings': 'lightline#ale#warnings',
        \ }
        let g:lightline.component_type = {
        \     'linter_checking': 'warning',
        \     'linter_errors': 'error',
        \     'linter_ok': 'left',
        \     'linter_warnings': 'warning',
        \ }
    "}
    endfunction
    autocmd Filetype python,json,sql call SetAleOptions()
    function! SetLightLSC()
        let g:LanguageClient_autoStart = 1
        let g:lightline#lsc#indicator_checking = "\ufbab"
        let g:lightline#lsc#indicator_errors = "\uf05e"
        let g:lightline#lsc#indicator_ok = "\uf00c"
        let g:lightline.active.right = [['linter_checking', 'linter_errors', 'linter_ok']] + g:lightline.active.right
        let g:lightline.component_expand = {
        \     'linter_checking': 'lightline#lsc#notStarted',
        \     'linter_errors': 'lightline#lsc#errors',
        \     'linter_ok': 'lightline#lsc#ok',
        \ }
        let g:lightline.component_type = {
        \     'linter_checking': 'warning',
        \     'linter_errors': 'error',
        \     'linter_ok': 'left',
        \ }
    endfunction
    autocmd Filetype c,cpp,rust,lua,r call SetLightLSC()
    "}
    " Denite
    " {
        call denite#custom#var('grep', 'command', ['rg'])
        call denite#custom#var('grep', 'default_opts',
                \ ['--vimgrep', '--no-heading'])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
        call denite#custom#var('grep', 'separator', ['--'])
        call denite#custom#var('grep', 'final_opts', [])
        nnoremap <leader>T :Denite -buffer-name=TODO -mode=normal grep:::TODO<cr>
        augroup vimrc_todo
            au!
            au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX)/
                  \ containedin=.*Comment,vimCommentTitle
        augroup END

        call denite#custom#alias('source', 'file/rec/git', 'file/rec')
        call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '--exclude-standard', ':/'])
        nnoremap <silent> <leader>f :Denite `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>
        hi def link MyTodo Todo
        "nnoremap <leader>f :DeniteProjectDir -buffer-name=project file<cr>
        nnoremap <leader>a :Denite -buffer-name=tags tag<cr>
        nnoremap <leader>d :Denite -buffer-name=tags tag -input=`expand('<cword>')` -mode=normal<cr>
        nnoremap <leader>b :Denite -buffer-name=buffer buffer -mode=normal<cr>
        nnoremap <leader>o :Denite -buffer-name=outline outline<cr>
        nnoremap <leader><c-g> :Denite -buffer-name=gitlog gitlog:all -mode=normal<cr>
        nnoremap <leader>g :DeniteProjectDir -buffer-name=grep grep:::`expand('<cword>')` -mode=normal <cr>
        vnoremap <leader>g y:DeniteProjectDir -buffer-name=grep grep:::`expand('<C-R>"')` -mode=normal <cr>
        nnoremap <leader>G :Denite -buffer-name=gitchanged gitchanged -mode=normal<cr>
        nnoremap <leader>y :Denite -buffer-name=yank-history neoyank -mode=normal<cr> call denite#custom#map('normal', 'a', '<denite:do_action:add>', 'noremap')
        call denite#custom#map('normal', 'd', '<denite:do_action:delete>', 'noremap')
        call denite#custom#map('normal', 'r', '<denite:do_action:reset>', 'noremap')
        call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
        call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
    " }
    " Toggle Gundo
    noremap <leader>u :GundoToggle<CR>
    " multiple-cursors
    vnoremap <leader>s :MultipleCursorsFind
    " Deoplete
    let g:deoplete#enable_at_startup=1
    set completeopt-=preview
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    " deoplete-rust
    set hidden
    "let g:deoplete#sources#rust#racer_binary = expand('~/.cargo/bin/racer')
    "let g:deoplete#sources#rust#rust_source_path = expand('~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src')
    " language client
    let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'cpp': ['clangd-7'],
    \ 'c': ['clangd-7'],
    \ 'lua': ['lua-lsp', '--config', '~/.config/lualsprc'],
    \ 'r': ['R', '--quiet', '--slave', '-e', 'languageserver::run()'],
    \ }
    let g:LanguageClient_selectionUI = "location-list"
    let g:LanguageClient_diagnosticsEnable = 1
    let g:LanguageClient_loggingLevel = 'DEBUG'
    set formatexpr=LanguageClient_textDocument_rangeFormatting()
    nnoremap <silent> K :call LanguageClient_textDocument_hover()<cr>
    nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
    nnoremap <silent> <leader>r :call LanguageClient_textDocument_rename()<cr>
    nnoremap <silent> <F3> :call LanguageClient_textDocument_references()<cr>
    nnoremap <silent> == :call LanguageClient_textDocument_formatting()<cr>
    " local-vimrc
    let g:localvimrc_sandbox = 0
    let g:localvimrc_ask = 0
    " vim-test
    nnoremap <silent> <leader>tn :TestNearest<cr>
    nnoremap <silent> <leader>tf :TestFile<cr>
    nnoremap <silent> <leader>ts :TestSuite<cr>
    nnoremap <silent> <leader>tl :TestLast<cr>
    nnoremap <silent> <leader>tg :TestVisit<cr>
    " gen_tags
    let g:loaded_gentags#gtags = 1
    let g:gen_tags#ctags_auto_gen = 1
    let g:gen_tags#ctags_prune = 1
    " neosnippet
    " {
        " Plugin key-mappings.
        " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
        imap <C-j>     <Plug>(neosnippet_expand_or_jump)
        smap <C-j>     <Plug>(neosnippet_expand_or_jump)
        xmap <C-j>     <Plug>(neosnippet_expand_target)

        " SuperTab like snippets behavior.
        " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
        imap <expr><TAB>
         \ pumvisible() ? "\<C-n>" :
         \ neosnippet#expandable_or_jumpable() ?
         \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

        " For conceal markers.
        if has('conceal')
          set conceallevel=2 concealcursor=niv
        endif
        " Enable snipMate compatibility feature.
        let g:neosnippet#enable_snipmate_compatibility = 1
    " }
    " echodoc
    let g:echodoc_enable_at_startup = 1
" }
