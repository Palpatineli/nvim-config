local M = {}
local ls = require'luasnip'
local s = ls.snippet
local i = ls.insert_node
local sn = ls.snippet_node
local t = ls.text_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require'luasnip.extras.fmt'.fmt
local setup = function()
    local function py_init()
        return c(1, { t(""), sn(1, { t(", "), i(1), d(2, py_init) }) })
    end
    local function to_init_assign(args)
        local tab = {}
        local a = args[1][1]
        if #(a) == 0 then
            table.insert(tab, t({"", "\tpass"}))
        else
            local cnt = 1
            for e in string.gmatch(a, " ?([^,]*) ?") do
                if #e > 0 then
                    table.insert(tab, t({"","\tself."}))
                    table.insert(tab, r(cnt, tostring(cnt), i(nil,e)))
                    table.insert(tab, t(" = "))
                    table.insert(tab, t(e))
                    cnt = cnt+1
                end
            end
        end
        return
        sn(nil, tab)
    end
    ls.add_snippets('python', {
        s('doc', fmt('"""{}\nArgs:\n\t{}: {}\nReturns:\n\t{}\n"""', {
            i(1, 'name'), i(2, 'arg'), i(3, 'arg_doc'), i(4, 'return')
        })
        ),
        s('np', {t('import numpy as np')}),
        s('pd', {t('import pandas as pd')}),
        s('plt', {t('from matplotlib import pyplot as plt')}),
        s("pyinit", fmt([[def __init__(self{}):{}]],
                        { d(1, py_init), d(2, to_init_assign, {1}) })),
    })
end
M.setup = setup
return M
