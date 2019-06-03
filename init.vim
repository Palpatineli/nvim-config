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
        call dein#add('w0rp/ale', {'on_ft': ['python', 'pandoc']})  " when language server doesn't work
        "call dein#add('neoclide/coc.nvim', {'tag': '*', 'do': 'yarn install',
            "\ 'on_ft': ['c', 'cpp', 'rust', 'lua', 'r', 'javascript', 'dot', 'css', 'scss', 'python',
            "\ 'json']})
        call dein#add('chrisbra/Colorizer')
        call dein#add('chrisbra/csv.vim', {'on_ft': ['csv', 'tsv']})
        call dein#add('Raimondi/delimitMate')
        call dein#add('Shougo/denite.nvim')
        call dein#add('neoclide/denite-git')
        call dein#add('mattn/emmet-vim', {'on_ft': ['html', 'txt', 'pandoc']})
        call dein#add('Konfekt/FastFold')
        call dein#add('tpope/vim-fugitive')
        call dein#add('jsfaint/gen_tags.vim')
        call dein#add('davidhalter/jedi-vim', {'on_ft': ['python']})
        " call dein#add('morhetz/gruvbox')
        " call dein#add('arcticicestudio/nord-vim')
        call dein#add('equalsraf/neovim-gui-shim')
        call dein#add('sjl/gundo.vim')
        call dein#add('othree/html5.vim', {'on_ft': ['html', 'txt', 'pandoc']})
        call dein#add('Yggdroot/indentLine')
        call dein#add('bfredl/nvim-ipy', {'on_ft': ['python']})
        call dein#add('elzr/vim-json', {'on_ft': ['log', 'json']})
        call dein#add('autozimu/LanguageClient-neovim', {'rev': 'next', 'build': 'bash install.sh',
            \ 'on_ft': ['c', 'cpp', 'rust', 'lua', 'r', 'javascript', 'json', 'dot', 'css',
                       \'scss']})
        " no python coz python has shitty language server til m$ft converts
        " theirs for general use
        call dein#add('itchyny/lightline.vim')
        call dein#add('embear/vim-localvimrc')
        call dein#add('lazywei/vim-matlab', {'on_ft': ['mat', 'matlab']})
        call dein#add('ncm2/ncm2')
        call dein#add('ncm2/ncm2-bufword')
        call dein#add('ncm2/ncm2-jedi', {'on_ft': ['python']})
        call dein#add('ncm2/ncm2-path')
        call dein#add('ncm2/ncm2-ultisnips')
        " call dein#add('drewtempelmeyer/palenight.vim')
        call dein#add('SirVer/ultisnips')
        call dein#add('Shougo/neoyank.vim')
        call dein#add('scrooloose/nerdcommenter')
        call dein#add('vim-pandoc/vim-pandoc', {'on_ft': ['markdown', 'txt', 'pandoc']})
        call dein#add('vim-pandoc/vim-pandoc-syntax', {'on_ft': ['markdown', 'txt', 'pandoc']})
        call dein#add('vim-pandoc/vim-pandoc-after', {'on_ft': ['markdown', 'txt', 'pandoc']})
        call dein#add('Vimjas/vim-python-pep8-indent', {'on_ft': ['python']})
        call dein#add('junegunn/rainbow_parentheses.vim')
        call dein#add('jalvesaq/Nvim-R.git', {'on_ft': ['r']})
        call dein#add('goldfeld/vim-seek')
        call dein#add('numirias/semshi', {'on_ft': ['python']})
        call dein#add('nightsense/snow.git')
        call dein#add('tmhedberg/SimpylFold', {'on_ft': ['python']})
        call dein#add('janko-m/vim-test')
        call dein#add('cespare/vim-toml', {'on_ft': ['r', 'toml']})
        call dein#add('tomtom/tlib_vim')
        call dein#add('roxma/nvim-yarp')
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
    set termguicolors
    " dim inactive pane in tmux; not working
    "au FocusLost hi Normal guifg='#7c6f64' guibg='#ebdbb2'
    "au FocusGained hi Normal guifg='#3c3836' guibg='#fbf1c7'
    set background=light
    colorscheme snow
    set t_Co=256
    set t_Sf=[3%p1%dm
    set t_Sb=[4%p1%dm

    filetype indent plugin on
    set updatetime=100
    set hidden
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
        set guifont=Monoisome\ 9
        set printfont=Monoisome\ 9
    endif
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
    au BufNewFile,BufRead *.md,*.txt set filetype=pandoc  " for vim-pandoc
    "au BufNewFile,BufRead *.txt set ff=dos
    au BufNewFile,BufRead *.csv,*.dat set filetype=csv  " for CSV files
    au BufNewFile,BufRead *.qml set filetype=javascript  " for qtquick
    au BufNewFile,BufRead *.g set filetype=antlr3  " for antlr
    au BufNewFile,BufRead *.g4 set filetype=antlr4
    au BufNewFile,BufRead *.ts set filetype=javascript  " for ts
    au BufNewFile,BufRead *.ino set filetype=c  " for auduino
" }

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
        set path+=~/Sync/paper/comment  " comment folder to jump to
        set path+=~/Sync/notes  " wiki folder to jump to
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
          \ 'colorscheme': 'snow_light',
          \ 'active': {
              \'left': [ [ 'mode', 'paste' ],
              \          [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
              \'right': [ [ 'lineinfo', 'lscinfo' ],
              \           [ 'percent' ],
              \           [ 'filetype'] ]
          \ },
          \ 'component_function': {
              \ 'filename': 'LightLineFilename',
              \ 'gitbranch': 'fugitive#head',
              \ 'lscinfo': 'LanguageClient#statusLine',
              \ 'cocstatus': 'coc#status'
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
    " Toggle Gundo
    noremap <leader>u :GundoToggle<CR>
    " multiple-cursors
    vnoremap <leader>s :MultipleCursorsFind
    " NCM2
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=noinsert,menuone,noselect
    set shortmess+=c
    inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'css',
        \ 'priority': 9, 
        \ 'subscope_enable': 1,
        \ 'scope': ['css','scss'],
        \ 'mark': 'css',
        \ 'word_pattern': '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete': ['ncm2#on_complete#delay', 180,
        \                 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })
    " ultisnips
    imap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
    let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/neosnippets']
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger = "<c-j>"
    "let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
    let g:UltiSnipsRemoveSelectModeMappings = 0
    " local-vimrc
    let g:localvimrc_sandbox = 0
    let g:localvimrc_ask = 0
    " vim-test
    nnoremap <silent> <leader>tn :TestNearest<cr>
    nnoremap <silent> <leader>tf :TestFile<cr>
    nnoremap <silent> <leader>ts :TestSuite<cr>
    nnoremap <silent> <leader>tl :TestLast<cr>
    nnoremap <silent> <leader>tg :TestVisit<cr>
    let test#strategy = {
      \ 'nearest': 'neovim',
    \}
    " gen_tags
    let g:loaded_gentags#gtags = 1
    let g:gen_tags#ctags_auto_gen = 1
    let g:gen_tags#ctags_prune = 1
    " indent line
    let g:indentLine_setColors = 1
    let g:indentLine_bgcolor_gui = '#fbffff'
    let g:indentLine_char = '▏'
    let g:indentLine_enabled = 1
    " vim json
    let g:vim_json_syntax_conceal = 0
    " rainbow parenthessi
    au BufNewFile,BufRead * RainbowParentheses
    " semantic highlighting
    let s:semanticGUIColors = [ '#72d572', '#c5e1a5', '#e6ee9c', '#fff59d', '#ffe082', '#ffcc80', '#ffab91', '#bcaaa4', '#b0bec5', '#ffa726', '#ff8a65', '#f9bdbb', '#f9bdbb', '#f8bbd0', '#e1bee7', '#d1c4e9', '#ffe0b2', '#c5cae9', '#d0d9ff', '#b3e5fc', '#b2ebf2', '#b2dfdb', '#a3e9a4', '#dcedc8' , '#f0f4c3', '#ffb74d' ]
    nnoremap <leader>c :SemanticHighlightToggle<cr>
" }
