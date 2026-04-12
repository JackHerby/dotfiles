-- https://github.com/ThePrimeagen/harpoon

---@module 'lazy'
---@type LazySpec
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })

    local function toggle_quick_menu()
      harpoon.ui:toggle_quick_menu(harpoon:list(), {
        ui_width_ratio = 0.6,
        ui_max_width = 120,
        height_in_lines = 10,
        border = 'rounded',
        title = 'Harpoon',
      })
    end

    local keymap = require('utils.keymap')
    keymap('<leader>ha', function() harpoon:list():add() end, { desc = 'Harpoon [a]dd' })
    keymap('<leader>hh', toggle_quick_menu, { desc = 'Harpoon [t]oggle' })
    keymap('<leader>hp', function() harpoon:list():prepend() end, { desc = 'Harpoon [p]repend' })
    keymap('<C-1>', function() harpoon:list():select(1) end)
    keymap('<C-2>', function() harpoon:list():select(2) end)
    keymap('<C-3>', function() harpoon:list():select(3) end)
    keymap('<C-4>', function() harpoon:list():select(4) end)
    keymap('<C-5>', function() harpoon:list():select(5) end)
    keymap('<C-6>', function() harpoon:list():select(6) end)
    keymap('<C-7>', function() harpoon:list():select(7) end)
    keymap('<C-8>', function() harpoon:list():select(8) end)
    keymap('<C-9>', function() harpoon:list():select(9) end)
    keymap('<C-0>', function() harpoon:list():select(0) end)
    keymap('<C-S-J>', function() harpoon:list():prev() end)
    keymap('<C-S-K>', function() harpoon:list():next() end)
  end,
}
