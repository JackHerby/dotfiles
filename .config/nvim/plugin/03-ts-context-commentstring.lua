-- A Neovim plugin for setting the commentstring option based on the cursor location in the file.

local github_url = require('utils.github_url')
vim.pack.add({
  github_url('JoosepAlviste/nvim-ts-context-commentstring'), -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
})
