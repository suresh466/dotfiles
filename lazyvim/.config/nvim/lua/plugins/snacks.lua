return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "Grep cwd" },
    { "<leader>sG", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
  },
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
