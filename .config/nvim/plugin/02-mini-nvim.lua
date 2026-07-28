-- Library of 40+ independent Lua modules improving overall Neovim (version 0.10 and higher) experience with minimal effort.

local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
local keymap = require('utils.keymap')

packAdd({
  githubUrl('echasnovski/mini.nvim'), -- https://github.com/echasnovski/mini.nvim
})

require('mini.bufremove').setup()
require('mini.diff').setup({ view = { style = 'sign' } })
require('mini.indentscope').setup()
require('mini.move').setup()
require('mini.statusline').setup({ use_icons = vim.g.have_nerd_font, })
---@diagnostic disable-next-line: duplicate-set-field
MiniStatusline.section_location = function() return '%2l:%-2v' end
require('mini.tabline').setup()
require('mini.trailspace').setup()

keymap('<leader>md', MiniBufremove.delete, { desc = '[D]elete buffer' })
keymap('<leader>ml', MiniTrailspace.trim_last_lines, { desc = 'Trim [l]ast lines' })
keymap('<leader>mt', MiniTrailspace.trim, { desc = '[T]rim' })
keymap('<leader>mu', MiniBufremove.unshow, { desc = '[U]nshow buffer' })
keymap('<leader>mw', MiniBufremove.wipeout, { desc = '[W]ipeout buffer' })
