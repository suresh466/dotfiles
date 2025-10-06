-- check what improvements does this config makes
-- {
--     type = "pwa-node",
--     request = "launch",
--     name = "Launch (Node)",
--     program = "${file}",
--     cwd = "${workspaceFolder}",
--     runtimeExecutable = "npx",
--     runtimeArgs = { "tsx" },
-- }

return {
  "mfussenegger/nvim-dap",
  opts = function()
    local dap = require("dap")

    dap.configurations.python = dap.configurations.python or {}

    table.insert(dap.configurations.python, {
      type = "python",
      request = "launch",
      name = "Django",
      program = "${workspaceFolder}/manage.py",
      django = true,
      -- justMyCode = false,
      args = function()
        local port = "8001"
        -- Schedule chromium launch after a short delay to wait for server
        vim.schedule(function()
          vim.defer_fn(function()
            vim.fn.jobstart({ "chromium", "http://localhost:" .. port })
          end, 500)
        end)
        return { "runserver", port, "--noreload", "--nothreading" }
      end,
    })

    -- ADD: Chrome adapter for React debugging
    if not dap.adapters["pwa-chrome"] then
      dap.adapters["pwa-chrome"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            LazyVim.get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }
    end

    -- Enhanced configurations with React support
    local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

    -- VS Code compatibility
    local vscode = require("dap.ext.vscode")
    vscode.type_to_filetypes["node"] = js_filetypes
    vscode.type_to_filetypes["pwa-node"] = js_filetypes
    vscode.type_to_filetypes["pwa-chrome"] = js_filetypes -- ADD this

    for _, language in ipairs(js_filetypes) do
      dap.configurations[language] = dap.configurations[language] or {}
      table.insert(dap.configurations[language], {
        type = "pwa-chrome",
        request = "attach",
        processId = require("dap.utils").pick_process,
        name = "Attach to React",
        port = 9222,
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
      })
      table.insert(dap.configurations[language], {
        type = "pwa-chrome",
        request = "launch",
        name = "Launch React App",
        url = "http://localhost:5173",
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
      })
    end
  end,
}
