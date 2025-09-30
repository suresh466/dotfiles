return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      htmldjango = { "djlint" },
    },
    formatters = {
      djlint = {
        prepend_args = { "--indent", "2", "--format-js", "--format-css", "--indent-js", "2", "--indent-css", "2" },
      },
    },
  },
}
