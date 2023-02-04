local ls = require('luasnip')
local types = require('luasnip.util.types')

ls.config.set_config({
    history = true, -- keep last snippet around, so you can jump back into it even if you move out of selection.
    updateevents = 'TextChanged, TextChangedI', -- Dynamic snippets updates as you type.
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { 'CCC', 'GruvboxYellow' } },
            },
        },
    },
})

-- Keymaps

-- Expand the current item or jump to the next item within the snippet
vim.keymap.set({ 'i', 's' }, '<c-k>', function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

-- Move backwards within a snippet.
vim.keymap.set({ 'i', 's' }, '<c-j>', function()
    if ls.jumpable() then
        ls.jump(-1)
    end
end, { silent = true })

-- For choicenodes
vim.keymap.set({ 'i', 's' }, '<c-l>', function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

-- Load snippets from friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

--cleanup later /\
-- Create lua snippet example.

-- snippet creator
-- s(<trigger>, <nodes>)
local s = ls.s

-- format node, it takes a format string, and a list of nodes
-- fmt(<fmt_string>, <...nodes>)
local fmt = require('luasnip.extras.fmt').fmt

-- insert node.
-- it takes a position (like $1 in vs style snips) and optionally some default text.
-- i(<position>, [default text])
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

-- repeats a node.
-- rep(<position>)
local rep = require('luasnip.extras').rep

-- insert and repeat node
ls.add_snippets('lua', {
    s('reqq', fmt([[<> <> repeat <>]], { i(2), i(1), rep(2) }, { delimiters = '<>' })),
})

-- choice node
ls.add_snippets('lua', {
    s('cnode', c(1, { t('choice 1'), t('Choice 2') })),
})

-- function node
ls.add_snippets('all', {
    s(
        'currtime',
        f(function()
            return os.date('%D - %H:%M')
        end)
    ),
})

-- replicating rep node to better understand function node
local same = function(index)
    return f(function(arg)
        print(vim.inspect(arg))
        return arg[1]
    end, { index })
end

ls.add_snippets('all', {
    s('sametest', fmt([[--example: {}, function: {}]], { i(1), same(1) })),
})

-- smart import snippet
local smart_import = function(import_name)
    local parts = vim.split(import_name[1][1], '.', true)
    return parts[#parts] or ''
end

ls.add_snippets('lua', {
    s('reqs', fmt([[ local {} = require '{}' ]], { f(smart_import, { 1 }), i(1) })),
})

-- reg trigger and dynamic nodes
ls.add_snippets('lua', {
    s(
        { trig = 'nor([%w_]+)', regTrig = true, hidden = true }, -- as mentioned hidden
        fmt(
            [[
            for <>=<>,<> do
                <>
            end
        ]],
            {
                d(1, function(_, snip)
                    return sn(1, i(1, snip.captures[1]))
                end),
                i(2, '1'),
                i(3, '10'),
                i(4, 'body'),
            },
            { delimiters = '<>' }
        )
    ),
})
