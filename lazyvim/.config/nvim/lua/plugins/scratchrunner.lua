return {
  "angeljreyes/scratch-runner.nvim",
  dependencies = "folke/snacks.nvim",
  opts = {
    sources = {
      javascript = { "node" },
      javascriptreact = { "node" },
      typescriptreact = { "node", "--experimental-strip-types", "--experimental-transform-types" },
      typescirpt = { "node --experimental-strip-types --experimental-transform-types" },
      python = { "python3" },
    },
  },
}
