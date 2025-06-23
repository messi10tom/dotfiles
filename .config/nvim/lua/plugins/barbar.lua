return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function() vim.g.barbar_auto_setup = false end,
  opts = {
    -- Enable/disable auto-hiding the tab bar when there is a single buffer
    auto_hide = false,
    -- Enable/disable current/total tabpages indicator (top right corner)
    tabpages = true,
    -- Enables/disable clickable tabs
    clickable = false,
    -- Excludes buffers from the tabline
    exclude_ft = { 'javascript' },
    exclude_name = { 'package.json' },
    -- A buffer to this direction will be focused (if it exists) when closing the current buffer
    focus_on_close = 'left',
    -- Hide inactive buffers and file extensions
    hide = { extensions = true, inactive = false },
    -- Disable highlighting alternate buffers
    highlight_alternate = false,
    -- Disable highlighting file icons in inactive buffers
    highlight_inactive_file_icons = false,
    -- Enable highlighting visible buffers
    highlight_visible = true,
    icons = {
      -- Configure the base icons on the bufferline
      buffer_index = false,
      buffer_number = false,
      button = '',
      -- Enables / disables diagnostic symbols
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'ﬀ' },
        [vim.diagnostic.severity.WARN] = { enabled = false },
        [vim.diagnostic.severity.INFO] = { enabled = false },
        [vim.diagnostic.severity.HINT] = { enabled = true },
      },
      gitsigns = {
        added = { enabled = true, icon = '+' },
        changed = { enabled = true, icon = '~' },
        deleted = { enabled = true, icon = '-' },
      },
      filetype = {
        -- Sets the icon's highlight group
        custom_colors = false,
        -- Requires `nvim-web-devicons`
        enabled = true,
      },
      separator = { left = '▎', right = '' },
      -- If true, add an additional separator at the end of the buffer list
      separator_at_end = true,
      -- Configure the icons on the bufferline when modified or pinned
      modified = { button = '●' },
      pinned = { button = '', filename = true },
      -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
      preset = 'default',
      -- Configure the icons on the bufferline based on the visibility of a buffer
      alternate = { filetype = { enabled = false } },
      current = { buffer_index = true },
      inactive = { button = '×' },
      visible = { modified = { buffer_number = false } },
    },
    -- If true, new buffers will be inserted at the start/end of the list
    insert_at_end = false,
    insert_at_start = false,
    -- Sets the maximum padding width with which to surround each tab
    maximum_padding = 1,
    -- Sets the minimum padding width with which to surround each tab
    minimum_padding = 1,
    -- Sets the maximum buffer name length
    maximum_length = 30,

    -- Sets the minimum buffer name length
    minimum_length = 0,

    -- If set, the letters for each buffer in buffer-pick mode will be assigned based on their name
    semantic_letters = true,

    -- New buffer letters are assigned in this order
    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

    -- Sets the name of unnamed buffers
    no_name_title = nil,
  },
  config = function(_, opts)
    require('barbar').setup(opts)

    -- Keymaps
    local map = vim.keymap.set
    local opts_silent = { noremap = true, silent = true }

    -- Move to previous/next
    map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts_silent)
    map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts_silent)

    -- Re-order to previous/next
    map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts_silent)
    map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts_silent)

    -- Goto buffer in position...
    map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts_silent)
    map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts_silent)
    map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts_silent)
    map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts_silent)
    map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts_silent)
    map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts_silent)
    map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts_silent)
    map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts_silent)
    map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts_silent)
    map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts_silent)

    -- Pin/unpin buffer
    map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts_silent)

    -- Close buffer
    map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts_silent)
    map('n', '<A-C>', '<Cmd>BufferClose!<CR>', opts_silent)

    -- Wipeout buffer
    map('n', '<A-w>', '<Cmd>BufferWipeout<CR>', opts_silent)

    -- Close commands
    map('n', '<A-s-c>', '<Cmd>BufferCloseAllButCurrent<CR>', opts_silent)
    map('n', '<A-s-p>', '<Cmd>BufferCloseAllButPinned<CR>', opts_silent)
    map('n', '<A-s-o>', '<Cmd>BufferCloseBuffersLeft<CR><Cmd>BufferCloseBuffersRight<CR>', opts_silent)

    -- Magic buffer-picking mode
    -- map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts_silent)

    -- Sort automatically by...
    map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts_silent)
    map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts_silent)
    map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts_silent)
    map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts_silent)
  end,
}
