local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
    diagnostics.flake8,
    formatting.stylua.with({
        extra_args = {
            '--quote-style',
            'AutoPreferSingle',
            '--indent-type',
            'Spaces',
        },
    }),
}

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
null_ls.setup({
    sources = sources,
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
