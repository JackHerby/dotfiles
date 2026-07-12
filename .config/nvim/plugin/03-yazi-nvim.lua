-- Yazi is a blazing fast file manager for the terminal.
-- This plugin allows you to open yazi in a floating window in Neovim.

local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
packAdd({
  githubUrl('mikavilpas/yazi.nvim'), -- https://github.com/mikavilpas/yazi.nvim
})

local keymap = require('utils.keymap')
keymap('<leader>yy', function() vim.cmd('Yazi cwd') end, { desc = "Open [Y]azi in Neovim's working directory." })
keymap('<leader>yf', function() vim.cmd('Yazi') end, { desc = 'Open Yazi at the current [f]ile.' })
keymap('<leader>yr', function() vim.cmd('Yazi toggle') end, { desc = '[R]esume Yazi session.' })

local nvimCreateAutocmd = require('utils.nvim-create-autocmd')
nvimCreateAutocmd('UIEnter', {
  callback = function()
    require('yazi').setup({
      open_for_directories = true,
      yazi_floating_window_border = 'single',
    })
  end,
})
