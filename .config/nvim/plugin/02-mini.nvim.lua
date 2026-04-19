-- Library of 40+ independent Lua modules improving overall Neovim (version 0.10 and higher) experience with minimal effort.

local githubUrl = require("utils.github-url")
vim.pack.add({
  githubUrl("echasnovski/mini.nvim"), -- https://github.com/echasnovski/mini.nvim
})

require("mini.ai").setup({ n_lines = 500 })

local miniBufremove = require("mini.bufremove")
miniBufremove.setup()
local keymap = require("utils.keymap")
keymap("<leader>bd", miniBufremove.delete, { desc = "[d]elete buffer" })
keymap("<leader>bw", miniBufremove.wipeout, { desc = "[w]ipeout buffer" })
keymap("<leader>bu", miniBufremove.unshow, { desc = "[u]nshow buffer" })

require("mini.diff").setup({
  view = {
    style = "sign",
  },
})

require("mini.move").setup()

local miniStatusline = require("mini.statusline")
miniStatusline.setup({
  use_icons = vim.g.have_nerd_font,
  section_location = function() return "%2l:%-2v" end,
})

require("mini.surround").setup()
