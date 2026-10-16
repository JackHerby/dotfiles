-- Distraction-free coding for Neovim >= 0.5

local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
local keymap = require('utils.keymap')

packAdd({
  githubUrl('folke/zen-mode.nvim'), -- https://github.com/folke/zen-mode.nvim
})

require('zen-mode').setup()

keymap(
  '<leader>z',
  function()
    require('zen-mode').toggle({
      window = { width = 0.55 },
    })
  end,
  { desc = 'Toggle [z]en mode' }
)
