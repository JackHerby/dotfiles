-- Library of 40+ independent Lua modules improving overall Neovim (version 0.10 and higher) experience with minimal effort.

local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
local keymap = require('utils.keymap')

packAdd({
  githubUrl('echasnovski/mini.nvim'), -- https://github.com/echasnovski/mini.nvim
})

require('mini.ai').setup({ n_lines = 500 })
require('mini.bufremove').setup()
require('mini.diff').setup({ view = { style = 'sign' } })
require('mini.move').setup()
require('mini.statuscolumn').setup()
require('mini.statusline').setup({ use_icons = vim.g.have_nerd_font })
---@diagnostic disable-next-line: duplicate-set-field
MiniStatusline.section_location = function() return '%2l:%-2v' end
require('mini.surround').setup()
require('mini.tabline').setup()
require('mini.trailspace').setup()

keymap('<leader>id', MiniBufremove.delete, { desc = '[D]elete buffer' })
keymap('<leader>il', MiniTrailspace.trim_last_lines, { desc = 'Trim [l]ast lines' })
keymap('<leader>it', MiniTrailspace.trim, { desc = '[T]rim' })
keymap('<leader>iu', MiniBufremove.unshow, { desc = '[U]nshow buffer' })
keymap('<leader>iw', MiniBufremove.wipeout, { desc = '[W]ipeout buffer' })
