local M = {}

local get_lsp_client = function()
    -- Get lsp client for current buffer
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.buf_get_clients()
    if next(clients) == nil then
        return nil
    end
    for _, client in pairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes,buf_ft) ~= -1 then
            return client
        end
    end
    return nil
end

M.get_lsp_client = get_lsp_client

M.setup = function()
    local actions = require('telescope.actions')
    local setup_keymap = function()
        vim.keymap.set('n', '<leader>f', function()
            require("telescope.builtin").git_files(require("telescope.themes").get_dropdown{previewer=false})
        end, {silent=true})
        vim.keymap.set('n', '<leader>e', require("telescope.builtin").diagnostics, {silent=true})
        vim.keymap.set('n', '<leader>F', require("telescope.builtin").lsp_references, {silent=true})
        vim.keymap.set('n', '<leader>d', require("telescope.builtin").lsp_definitions, {silent=true})
        vim.keymap.set('n', '<leader>i', require("telescope.builtin").lsp_implementations, {silent=true})
        vim.keymap.set('n', '<leader>o', require("telescope.builtin").treesitter, {silent=true})
        vim.keymap.set('n', '<leader>a', function()
            require("telescope.builtin").live_grep{cwd=get_lsp_client().config.root_dir}
        end, {silent=true})
        vim.keymap.set('n', '<leader>A', function()
           require("telescope.builtin").grep_string{cwd=get_lsp_client().config.root_dir}
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
