-- Smart Window Resize
-- This plugin provides window management that automatically resizes windows when moving between them

-- Configuration variables
local config = {
  -- The key to use as a modifier (e.g., <C->, <A->, etc.)
  -- Leave as empty string if you want to use raw h/j/k/l without modifiers
  modifier = "<C-w>",

  -- Predefined sizes for shrinking windows
  width = 30,   -- Width in columns when shrinking horizontally
  height = 10,  -- Height in lines when shrinking vertically

  -- Reset key to restore original window sizes
  -- reset_key = "r",

  -- Keys for navigation
  keys = {
    left = "h",
    down = "j",
    up = "k",
    right = "l"
  }
}

-- Store original window sizes to allow reset
local original_sizes = {}
local has_resized = false

-- Save the current window layout
local function save_window_layout()
  original_sizes = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(win) then
      original_sizes[win] = {
        width = vim.api.nvim_win_get_width(win),
        height = vim.api.nvim_win_get_height(win)
      }
    end
  end
end

-- -- Restore the original window layout
-- local function restore_window_layout()
--   for win, sizes in pairs(original_sizes) do
--     if vim.api.nvim_win_is_valid(win) then
--       vim.api.nvim_win_set_width(win, sizes.width)
--       vim.api.nvim_win_set_height(win, sizes.height)
--     end
--   end
--   has_resized = false
-- end

-- Smart resize and focus function
local function smart_resize_and_focus(direction)
  -- Save original sizes if this is the first resize
  if not has_resized then
    save_window_layout()
    has_resized = true
  end

  -- Get current window
  local current_win = vim.api.nvim_get_current_win()

  -- Move to the target window
  vim.cmd("wincmd " .. direction)

  -- If we didn't move, return
  local new_win = vim.api.nvim_get_current_win()
  if current_win == new_win then
    return
  end

  -- Determine if this is a horizontal or vertical move
  local is_horizontal = (direction == "h" or direction == "l")

  -- Resize the previous window
  vim.api.nvim_set_current_win(current_win)
  if is_horizontal then
    vim.api.nvim_win_set_width(current_win, config.width)
  else
    vim.api.nvim_win_set_height(current_win, config.height)
  end

  -- Focus back to the target window
  vim.api.nvim_set_current_win(new_win)
end

-- Setup keymaps
local function setup_keymaps()
  -- Navigation keys that resize
  vim.keymap.set('n', config.modifier .. config.keys.left, function() smart_resize_and_focus('h') end, { silent = true, desc = "Focus left and resize" })
  vim.keymap.set('n', config.modifier .. config.keys.down, function() smart_resize_and_focus('j') end, { silent = true, desc = "Focus down and resize" })
  vim.keymap.set('n', config.modifier .. config.keys.up, function() smart_resize_and_focus('k') end, { silent = true, desc = "Focus up and resize" })
  vim.keymap.set('n', config.modifier .. config.keys.right, function() smart_resize_and_focus('l') end, { silent = true, desc = "Focus right and resize" })

  -- Reset key
end

-- Main setup function for the plugin
local function setup(user_config)
  -- Merge user config with defaults
  if user_config then
    for k, v in pairs(user_config) do
      if type(v) == "table" and type(config[k]) == "table" then
        for k2, v2 in pairs(v) do
          config[k][k2] = v2
        end
      else
        config[k] = v
      end
    end
  end

  setup_keymaps()
end

-- Return the module
return {
  setup = setup
}
