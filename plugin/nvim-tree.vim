let g:lua_tree_ignore = [ '.git', 'node_modules', '.cache', '__pycache__', '.idea', '*.egg-info' ]
let g:lua_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:lua_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
let g:lua_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:lua_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:lua_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:lua_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:lua_tree_width_allow_resize  = 1 "0 by default, will not resize the tree when opening a file

nnoremap <F2> :LuaTreeToggle<CR>
nnoremap <leader>n :LuaTreeFindFile<CR>
highlight LuaTreeFolderIcon guibg=blue
