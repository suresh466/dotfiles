return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false,
      float = {
        source = true,
        border = "rounded",
      },
      underline = false,
    },
  },
}
-- use this style to update a server list for example (deep_extend only merge tables not lists )
-- {
--   "hrsh7th/nvim-cmp",
--   opts = function(_, opts)
--     table.insert(opts.sources, { name = "emoji" })
--   end,
-- }
