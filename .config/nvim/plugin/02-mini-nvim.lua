-- Library of 40+ independent Lua modules improving overall Neovim (version 0.10 and higher) experience with minimal effort.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
local keymap = require("utils.keymap")

packAdd({
    githubUrl("echasnovski/mini.nvim"), -- https://github.com/echasnovski/mini.nvim
})

require("mini.move").setup()
require("mini.statuscolumn").setup()
require("mini.statusline").setup({ use_icons = vim.g.have_nerd_font })
---@diagnostic disable-next-line: duplicate-set-field
MiniStatusline.section_location = function() return "%2l:%-2v" end
require("mini.tabline").setup()
