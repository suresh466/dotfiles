return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Apply to all filetypes
      ["*"] = { "trim_whitespace" },
      -- Apply to any that has no formatter
      ["_"] = { "trim_newlines" },
      python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
      htmldjango = { "djlint" },
      rust = { "rustfmt" },
      nginx = { "nginxfmt" },
      astro = { "prettier", "rustywind" },
      caddy = { "caddyfmt" },
      javascriptreact = { "rustywind" },
      typescriptreact = { "rustywind" },
      css = { "prettier" },
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
