local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require('window').setup({
  -- Set to your preferred modifier key
  -- Leave as empty string if you want to use raw h/j/k/l
  modifier = "<C-w>", -- Ctrl+w is the default Vim window prefix

  -- Customize these sizes
  width = 30,   -- Width when shrinking horizontally
  height = 10,  -- Height when shrinking vertically

  -- Reset key
  reset_key = "r",
})

require("vim-options")
require("lazy").setup("plugins")
