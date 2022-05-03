local actions = require('telescope.actions')
-- Global remapping
------------------------------
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

local setup_keymap = function()
    vim.api.nvim_set_keymap('n', '<leader>f', ':lua require("telescope.builtin").git_files(require("telescope.themes").get_dropdown{previewer = false})<cr>', {silent=true})
    vim.api.nvim_set_keymap('n', '<leader>b', ':lua require("telescope.builtin").buffers(require("telescope.themes").get_dropdown{previewer = false})<cr>', {silent=true})
    vim.api.nvim_set_keymap('n', '<leader>e', ':lua require("telescope.builtin").diagnostics{}<cr>', {silent=true})
    vim.api.nvim_set_keymap('n', '<leader>F', ':lua require("telescope.builtin").lsp_references()<cr>', {silent=true})
    vim.api.nvim_set_keymap('n', '<leader>d', ':lua require("telescope.builtin").lsp_definitions()<cr>', {silent=true})
    vim.api.nvim_set_keymap('n', '<leader>i', ':lua require("telescope.builtin").lsp_implementations()<cr>', {silent=true})
    vim.api.nvim_set_keymap('n', '<leader>o', ':lua require("telescope.builtin").treesitter()<cr>', {silent=true})
    vim.api.nvim_set_keymap('n', '<leader>a', ':lua require("telescope.builtin").live_grep{cwd=require"telescope-setting".get_lsp_client().config.root_dir}<cr>', {silent=true})
    vim.api.nvim_set_keymap('n', '<leader>A', ':lua require("telescope.builtin").grep_string{cwd=require"telescope-setting".get_lsp_client().config.root_dir}<cr>', {silent=true})
end

setup_keymap()
return M
