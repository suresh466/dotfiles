return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      htmldjango = { "djlint" },
      rust = { "rustfmt" },
      nginx = { "nginxfmt" },
      astro = { "prettier", "rustywind" },
      caddy = { "caddyfmt" },
    },
    formatters = {
      djlint = {
        prepend_args = { "--indent", "2", "--format-js", "--format-css", "--indent-js", "2", "--indent-css", "2" },
      },
      caddyfmt = {
        command = "caddy",
        args = { "fmt", "-" },
        stdin = true,
      },
    },
  },
}
