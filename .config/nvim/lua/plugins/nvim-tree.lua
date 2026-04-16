-- A File Explorer For Neovim Written In Lua.

---@module 'lazy'
---@type LazySpec
return {
  'nvim-tree/nvim-tree.lua', -- https://github.com/nvim-tree/nvim-tree.lua
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- https://github.com/nvim-tree/nvim-web-devicons
  },
  config = function(_, opts)
    require('nvim-tree').setup(opts)

    local keymap = require('utils.keymap')
    keymap('<leader>ec', '<cmd>NvimTreeCollapse<CR>', { desc = '[c]ollapse nvim-tree recursively' })
    keymap('<leader>ef', '<cmd>NvimTreeFindFile<CR>', { desc = 'move cursor to current [f]ile in Nvim Tree' })
    keymap('<leader>eg', '<cmd>NvimTreeFindFileToggle<CR>', { desc = 'find file or to[g]gle Nvim Tree' })
    keymap('<leader>er', '<cmd>NvimTreeRefresh<CR>', { desc = '[r]efresh Nvim Tree' })
    keymap('<leader>es', '<cmd>NvimTreeFocus<CR>', { desc = 'Nvim Tree focu[s]' })
    keymap('<leader>ee', '<cmd>NvimTreeToggle<CR>', { desc = '[t]oggle Nvim Tree' })
  end,
  opts = {
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
    disable_netrw = true,
    view = {
      width = function() return math.floor(vim.o.columns * 0.33) end,
      side = 'right',
      number = true,
      cursorline = true,
    },
  },
}
