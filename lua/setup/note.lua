M = {}
local match_link = function(pattern)
    local qry = string.format("fd -t file -e txt -e md %s %s", pattern:sub(3, -3), vim.g.note_root)
    local f = io.popen(qry)
    local s = f:read("l")
    return s
end

M.follow_link = function()
    local word = string.match(vim.fn.expand("<cWORD>"), "%[%[([A-Za-z0-9_%-]+)%]%]", 1)
    if word == nil then
        error("no link undercursor")
        return
    end
    local file_path = match_link(word)
    if file_path == nil then
        file_path = string.format("%s/%s.txt", vim.g.note_root, word)
    end
    vim.cmd("edit " .. file_path)
end

M.neorg = function()
    require('neorg').setup {
        load = {
            ['core.defaults'] = {},
            ['core.gtd.base'] = {
                config ={
                    workspace = 'central',
                    default_lists = { inbox = "inbox.norg" },
                    syntax = { context = "#contexts", start = "#time.start",
                               due = "#time.due", waiting = "#waiting.for", },
                    displayers = { projects = { show_completed_projects = false, show_projects_without_tasks = true }},
                    custom_tag_completion = true
                }
            },
            ['core.norg.concealer'] = {},
            ['core.norg.completion'] = {config = {engine = "nvim-cmp"}},
            ['core.norg.dirman'] = {
                config = {
                    workspaces = {
                        central = "~/Sync/note"
                    }
                }
            },
            ['core.integrations.telescope'] = {},
        },
        hook = function()
             local neorg_callbacks = require('neorg.callbacks')
             neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
                keybinds.map_event_to_mode("norg", {
                    n = {
                        { "<leader>gd", "core.norg.qol.todo_items.todo.task_done" },
                        { "<leader>gu", "core.norg.qol.todo_items.todo.task_undone" },
                        { "<leader>gp", "core.norg.qol.todo_items.todo.task_pending" },
                        { "<C-Space>", "core.norg.qol.todo_items.todo.task_cycle" },
                        { "<leader>gl", "core.integrations.telescope.find_linkable" },
                    },
                    i = {
                        { "<c-l>", "core.integrations.telescope.insert_link" },
                    },
                }, { silent = true, noremap = true })
            end)
        end
    }
    vim.keymap.set("n", "<leader>gv", ":Neorg gtd views<CR>", {})
    vim.keymap.set("n", "<leader>gc", ":Neorg gtd capture<CR>", {})
    vim.keymap.set("n", "<leader>ge", ":Neorg gtd edit<CR>", {})
end

return M
