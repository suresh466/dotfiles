local M = {}

local function configure()
    local dap_breakpoint = {
        error = {
            text = '🟥',
            texthl = 'LspDiagnosticsSignError',
            linehl = '',
            numhl = '',
        },
        rejected = {
            text = '',
            texthl = 'LspDiagnosticsSignHint',
            linehl = '',
            numhl = '',
        },
        stopped = {
            text = '⭐️',
            texthl = 'LspDiagnosticsSignInformation',
            linehl = 'DiagnosticUnderlineInfo',
            numhl = 'LspDiagnosticsSignInformation',
        },
    }

    vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
    vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)
    vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)
end

local function configure_exts()
    require('nvim-dap-virtual-text').setup({
        commented = true,
    })
end

local dap, dapui = require('dap'), require('dapui')
dapui.setup({}) -- use default

dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open(_)
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close(_)
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close(_)
end

local function configure_debuggers()
    require('dap-config.python').setup()
end

configure() -- Configuration
configure_exts() -- Extensions
configure_debuggers() -- Debugger
require('dap-config.keymaps').setup() -- Keymaps

--function M.setup()
--    configure() -- Configuration
--    configure_exts() -- Extensions
--    configure_debuggers() -- Debugger
--    require('dap-config.keymaps').setup() -- Keymaps
--end
return M
