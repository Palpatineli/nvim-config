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

local grep_file_tag = function()
    local tag = vim.fn.expand('%<')  -- needs the escape as [ is special in telescope
    local root_dir = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
    require("telescope.builtin").grep_string{cwd=root_dir, search=tag}
end

vim.keymap.set('n', '<leader>z', grep_file_tag, {noremap = true})

M.zk = function()
    require'zk'.setup{
        picker='telescope',
    }
end

-- todotxt
M.todo = function()
    local todo = require'todotxt-nvim'
    todo.setup{todo_file='~/Sync/note/todo.txt'}
    vim.keymap.set('n', '<leader>to', todo.toggle_task_pane)
    vim.keymap.set('n', '<leader>ta', todo.capture)
end

M.mind = function()
    local mind = require'mind'
    local open_local_mind = function()
        local root_dir = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
        if root_dir:find('^fatal') then
            local old_path = vim.fn.getcwd()
            os.execute('cd '..root_dir)
            require'mind'.open_project(false)
            os.execute('cd '..old_path)
        else
        end
    end
    mind.setup{
        persistence = {
            state_path = "~/Sync/note/mind.json",
            data_dir = "~/Sync/note/"
        },
        edit={
            data_extension=".txt"
        }
    }
    vim.keymap.set('n', '<leader>tm', mind.open_main)
    vim.keymap.set('n', '<leader>tp', open_local_mind)
end

M.neorg = function()
    require'neorg'.setup{
        load = {
            ["core.defaults"] = {},
            ["core.export"] = {},
            ["core.norg.dirman"] = {
                config = {
                    workspaces = {
                        work = "~/Sync/note/work",
                        home = "~/Sync/note/home",
                    }
                }
            },
            ["core.gtd.base"] = {
                config = {
                    workspace = 'work'
                }
            },
            ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
            ["core.norg.concealer"] = {},
            ["core.integrations.telescope"] = {},
            ["external.gtd-project-tags"] = { config = {
                show_completed = false,
                show_future = true,
                show_extra = true,
            } }
        }
    }
    -- require('cmp').setup.buffer({ sources = {{ name = 'neorg' }} })
end

local follow_link = function()
    if require'obsidian'.util.cursor_on_markdown_link() then
        return '<cmd>ObsidianFollowLink<CR>'
    else
        return 'gf'
    end
end

local get_path = function(str)
    return str:match("(.*[/\\])")
end

M.obsidian = function()
    require'obsidian'.setup{
        dir="~/Sync/note",
        daily_notes = { folder = "dailies" },
        completion={nvim_cmp = true}
    }
    vim.keymap.set('n', 'gf', follow_link, {noremap=false, expr=true})
    vim.keymap.set('n', '<leader>ob', '<cmd>ObsidianBacklinks<cr>', {noremap=false})
    vim.keymap.set('n', '<leader>os', '<cmd>ObsidianSearch<cr>', {noremap=false})
    vim.keymap.set('v', '<leader>ol', '<cmd>ObsidianLink<cr>', {noremap=false})
end

return M
