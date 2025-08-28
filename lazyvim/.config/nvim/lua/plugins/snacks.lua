return {
  "folke/snacks.nvim",
  opts = {
    -- smooth scrolling
    scroll = {
      enabled = false,
    },
    terminal = {
      win = { position = "float" },
    },
    picker = {
      layout = { preset = "default", layout = { height = 0.99, width = 0.99 } },
      sources = {
        -- keymaps = { layout = "telescope" },
        -- files = {
        --   layout = "default",
        -- },
      },
    },
  },
}
