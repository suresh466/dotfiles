local M = {}

local whichkey = require('which-key')
-- local function keymap(lhs, rhs, desc)
--   vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
-- end
function M.setup()
    local keymap = {
        d = {
            name = 'Debug',
            e = { "<cmd>lua require'dapui'.eval()<cr>", 'Evaluate' },
            E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", 'Evaluate Input' },
            u = { "<cmd>lua require'dapui'.toggle()<cr>", 'Toggle UI' },

            R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", 'Run to Cursor' },
            C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", 'Conditional Breakpoint' },
            b = { "<cmd>lua require'dap'.step_back()<cr>", 'Step Back' },
            c = { "<cmd>lua require'dap'.continue()<cr>", 'Continue' },
            d = { "<cmd>lua require'dap'.disconnect()<cr>", 'Disconnect' },
            g = { "<cmd>lua require'dap'.session()<cr>", 'Get Session' },
            h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", 'Hover Variables' },
            S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", 'Scopes' },
            j = { "<cmd>lua require'dap'.step_into()<cr>", 'Step Into' },
            o = { "<cmd>lua require'dap'.step_over()<cr>", 'Step Over' },
            p = { "<cmd>lua require'dap'.pause.toggle()<cr>", 'Pause' },
            q = { "<cmd>lua require'dap'.close()<cr>", 'Quit' },
            r = { "<cmd>lua require'dap'.repl.toggle()<cr>", 'Toggle Repl' },
            s = { "<cmd>lua require'dap'.continue()<cr>", 'Start' },
            t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", 'Toggle Breakpoint' },
            x = { "<cmd>lua require'dap'.terminate()<cr>", 'Terminate' },
            J = { "<cmd>lua require'dap'.step_out()<cr>", 'Step Out' },
            l = { "<cmd>lua require'dap'.run_last()<cr>", 'Re-run last' },
            f = { "<cmd>lua require'dap-python'.test_method()<cr>", 'test method' },
            T = { "<cmd>lua require'dap-python'.test_class()<cr>", 'test class' },
        },
    }

    whichkey.register(keymap, {
        mode = 'n',
        prefix = '<leader>',
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false,
    })

    local keymap_v = {
        name = 'Debug',
        e = { "<cmd>lua require'dapui'.eval()<cr>", 'Evaluate' },
        v = { "<cmd>lua require'dap-python'.debug_selection()<cr>", 'debug selected' },
    }
    whichkey.register(keymap_v, {
        mode = 'v',
        prefix = '<leader>',
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false,
    })
end

return M
