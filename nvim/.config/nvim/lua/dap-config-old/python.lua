local M = {}

function M.setup(_)
    require('dap-python').setup('~/.virtualenvs-py/debugpy/bin/python')

    --django config
    table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Django',
        program = vim.fn.getcwd() .. '/manage.py',
        args = { 'runserver', '--noreload' },
    })

    local dap = require('dap')
    --djangohtml adapter
    dap.adapters.htmldjango = {
        type = 'executable',
        command = '/home/hawk/.virtualenvs-py/debugpy/bin/python',
        args = { '-m', 'debugpy.adapter' },
    }

    --djangohtml config
    dap.configurations.htmldjango = {
        {
            -- The first three options are required by nvim-dap
            type = 'htmldjango', -- the type here established the link to the adapter definition: `dap.adapters.python`
            request = 'launch',
            name = 'Htmldjango',

            -- Options below are for debugpy
            args = { 'runserver', '--noreload' },
            django = 'true',
            program = vim.fn.getcwd() .. '/manage.py',
            pythonPath = function()
                -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                -- The code below refers to virtualenv environment variable first then it looks for a `venv` or `.venv` folder in
                -- the current directly and uses the python within.
                local cwd = vim.fn.getcwd()
                local v_env = require('os').getenv('VIRTUAL_ENV')

                if vim.fn.executable(v_env .. '/bin/python') == 1 then
                    return v_env .. '/bin/python'
                elseif vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                    return cwd .. '/venv/bin/python'
                elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                    return cwd .. '/.venv/bin/python'
                else
                    return '/usr/bin/python'
                end
            end,
        },
    }
end

return M
