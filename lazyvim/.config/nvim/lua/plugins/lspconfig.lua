return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.diagnostics.virtual_text = false
    opts.diagnostics.float = {
      source = true,
      border = "rounded",
    }
  end,
}
