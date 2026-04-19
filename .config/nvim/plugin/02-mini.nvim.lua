-- Library of 40+ independent Lua modules improving overall Neovim (version 0.10 and higher) experience with minimal effort.

local githubUrl = require('utils.github-url')
vim.pack.add({
  githubUrl('echasnovski/mini.nvim'), -- https://github.com/echasnovski/mini.nvim
})

require('mini.ai').setup({ n_lines = 500 })

local mini_bufremove = require('mini.bufremove')
mini_bufremove.setup()
local keymap = require('utils.keymap')
keymap('<leader>bd', mini_bufremove.delete, { desc = '[d]elete buffer' })
keymap('<leader>bw', mini_bufremove.wipeout, { desc = '[w]ipeout buffer' })
keymap('<leader>bu', mini_bufremove.unshow, { desc = '[u]nshow buffer' })

require('mini.diff').setup({
  view = {
    style = 'sign',
  },
})

require('mini.move').setup()

local mini_statusline = require('mini.statusline')
mini_statusline.setup({
  use_icons = vim.g.have_nerd_font,
  section_location = function() return '%2l:%-2v' end,
})

require('mini.surround').setup()
