return {
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
  keys = {
    { "<leader>.o", "<cmd>SymbolsOutline<CR>", desc = "Toggle Symbols Outline" },
    { "<leader>.c", "<C-w>p", desc = "Focus Code Window" },
  },
  config = function()
    require("symbols-outline").setup({
      position = "right",
      width = 25,
      auto_close = false,
    })
  end,
}

