local M = {}
M.setup = function()
    local actions = require('telescope.actions')
    local setup_keymap = function()
        vim.keymap.set('n', '<space>f', function()
            require("telescope.builtin").git_files(require("telescope.themes").get_dropdown{previewer=false})
        end, {silent=true})
        vim.keymap.set('n', '<space>d', require("telescope.builtin").diagnostics, {silent=true})
        vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, {silent=true})
        vim.keymap.set('n', 'gd', require("telescope.builtin").lsp_definitions, {silent=true})
        vim.keymap.set('n', 'gi', require("telescope.builtin").lsp_implementations, {silent=true})
        vim.keymap.set('n', '<space>o', require("telescope.builtin").treesitter, {silent=true})
        vim.keymap.set('n', '<space>a', function()
            require("telescope.builtin").live_grep{cwd=vim.lsp.buf.list_workspace_folders()[1]}
        end, {silent=true})
        vim.keymap.set('n', '<space>A', function()
           require("telescope.builtin").grep_string{cwd=vim.lsp.buf.list_workspace_folders()[1]}
        end, {silent=true})
    end

    require('telescope').setup{
      defaults = {
        mappings = {
          i = {
            ["<c-j>"] = actions.move_selection_next,
            ["<c-k>"] = actions.move_selection_previous,
          },
        },
      }
    }
    setup_keymap()
end
return M
