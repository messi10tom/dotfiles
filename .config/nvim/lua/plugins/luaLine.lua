return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto', -- use your colorscheme
        icons_enabled = true,
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { { 'mode', icon = '' } },
        lualine_b = {
          { 'branch', icon = '' },
          {
            'diff',
            symbols = { added = '+', modified = '~', removed = '-' },
            colored = true,
          },
        },
        lualine_c = {
          { 'filename', path = 1 }, -- 0: just name, 1: relative path, 2: absolute
        },
        lualine_x = {
          'encoding',
          'fileformat',
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { { 'location', icon = '' } },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'fugitive', 'nvim-tree', 'quickfix' },
    }
  end,
}

