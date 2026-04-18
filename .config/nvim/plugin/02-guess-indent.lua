-- Blazing fast indentation style detection for Neovim written in Lua.

local github_url = require('utils.github_url')
vim.pack.add({
  github_url('NMAC427/guess-indent.nvim'), -- https://github.com/NMAC427/guess-indent.nvim
})

require('guess-indent').setup({})
