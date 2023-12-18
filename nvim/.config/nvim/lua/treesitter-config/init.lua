require('nvim-treesitter.configs').setup({
    ensure_installed = { 'c', 'lua', 'python', 'javascript', 'typescript' },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,
    highlight = {
        -- `false` will disable the whole extension
        enable = true,
    },
{
        highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
        },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = 'grr',
            },
        },
    },
    require('treesitter-context').setup(
    {
        mode='cursor', max_lines=3,
    }),
})
