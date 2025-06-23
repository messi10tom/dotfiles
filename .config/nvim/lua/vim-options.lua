-- my personal configs
vim.keymap.set("n", "$", "g_")
vim.keymap.set("n", "<CR>", "o<Esc>", { desc = "Newline below and stay" })
vim.keymap.set("n", "<Esc>", "<Cmd>noh<CR><Esc>")
vim.keymap.set("n", "<C-s>", "<cmd>wa<CR>")
vim.keymap.set("n", "<leader>c", function()
  vim.cmd("normal! A;")
end, { noremap = true })

vim.keymap.set("i", "<M-h>", "<Left>")   -- Alt+h
vim.keymap.set("i", "<M-j>", "<Down>")   -- Alt+j
vim.keymap.set("i", "<M-k>", "<Up>")     -- Alt+k
vim.keymap.set("i", "<M-l>", "<Right>")  -- Alt+l

local function setup_keymap()
  local filetype = vim.bo.filetype
  if filetype == "rust" or filetype == "cpp" then
    -- For Rust and C++: add semicolon at end and newline below
    vim.keymap.set("i", "<M-m>", "<C-o>A;<CR>", { buffer = true, desc = "Add semicolon and newline below" })
  else
    -- Default behavior for other filetypes
    vim.keymap.set("i", "<M-m>", "<C-o>$<CR>", { buffer = true, desc = "Insert newline below and stay" })
  end
end

-- Set up autocommand to apply the keymap when filetype is detected
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = setup_keymap,
})

-- Folding configuration
vim.opt.foldmethod = 'syntax'  -- 'indent' works well for Lua
vim.opt.foldlevelstart = 99    -- Start with all folds open
vim.opt.foldenable = true

-- Optional: customize fold appearance
vim.opt.fillchars = vim.opt.fillchars + 'fold: '
vim.opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]


vim.keymap.set('n', '<C-h>', '<Cmd>wincmd h<CR>', { noremap = true })

-- Remap Ctrl + h/j/k/l to window movement
vim.keymap.set('n', '<C-h>', ':wh<CR>')
vim.keymap.set('n', '<C-j>', ':wj<CR>')
vim.keymap.set('n', '<C-k>', ':wk<CR>')
vim.keymap.set('n', '<C-l>', ':wl<CR>')

-- -- gets info/man/help
-- vim.keymap.set("n", "K", function()
--   local word = vim.fn.expand("<cword>")
--   vim.cmd("!man 2 " .. word)
-- end)


-- reload key
vim.keymap.set("n", "<leader>rr", function ()
  dofile(vim.env.MYVIMRC)
  print("Reloaded init.lua")
end)

-- one relativeNumberline for all the window
vim.opt.number = false
vim.opt.relativenumber = false

vim.api.nvim_create_autocmd({"BufEnter", "WinEnter", "FocusGained"}, {
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = true
  end,
})

vim.api.nvim_create_autocmd({"BufLeave", "WinLeave", "FocusLost"}, {
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})

-- Yanking to clipboard
vim.keymap.set({"n", "v"}, "y", '"+y')
vim.keymap.set("n", "yy", '"+yy')
vim.keymap.set({"n", "v"}, "p", '"+p')
vim.keymap.set({"n", "v"}, "d", '"+d')

-- expandable block selection
vim.keymap.set("n", "<leader>ve", function ()
  vim.opt.virtualedit = "onemore"
end, { desc = "Enable virtualedit=onemore" })


vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.localleader = " "
vim.opt.swapfile = false

-- Navigate vim panes better
-- vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
-- vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
-- vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
-- vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
--
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true


vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
