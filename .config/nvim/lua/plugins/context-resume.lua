return {
  -- dir = "~/GitHub/context-resume/",
  -- -- "messi10tom/context-resume.nvim",
  --
  -- name = "context-resume",
  -- lazy = false, -- Load on startup to catch BufEnter events
  --
  -- config = function()
  --   require("context-resume").setup({
  --     -- Configuration options
  --     enabled = true,
  --     auto_show = true,
  --     position = "top-right", -- top-right, top-left, bottom-right, bottom-left
  --     width = 60,
  --     height = 15,
  --     border = "rounded",
  --     timeout = 100000, -- auto-dismiss after 5 seconds (0 to disable)
  --     export_meta = false, -- export to .filename.meta.yaml
  --
  --     -- Enable/disable specific metadata modules
  --     modules = {
  --       filepath = true,
  --       git = true,
  --       filetype = true,
  --       lsp_diagnostics = true,
  --       cursor_position = true,
  --       todos = true,
  --       last_modified = true,
  --       custom_notes = true,
  --     }
  --   })
  --
  --   -- Optional key mappings
  --   vim.keymap.set('n', '<leader>cr', '<cmd>ContextResume<cr>', { desc = "Show Context Resume" })
  --   vim.keymap.set('n', '<leader>ct', '<cmd>ContextResumeToggle<cr>', { desc = "Toggle Context Resume" })
  -- end,
  --
  -- -- No dependencies beyond Neovim built-ins
  -- dependencies = {},
}

-- Example of adding a custom module after setup:
--[[
vim.defer_fn(function()
  require("context-resume").add_module("word_count", function(filepath)
    local lines = vim.fn.readfile(filepath)
    local word_count = 0
    for _, line in ipairs(lines) do
      word_count = word_count + #vim.split(line, "%s+")
    end
    return { "📊 " .. word_count .. " words" }
  end)
end, 1000)
--]]
