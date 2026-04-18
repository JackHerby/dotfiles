local github_url = require('utils.github_url')
vim.pack.add({
  github_url('nvim-tree/nvim-web-devicons'), -- https://github.com/nvim-tree/nvim-web-devicons
  github_url('nvim-lua/plenary.nvim'), -- https://github.com/nvim-lua/plenary.nvim
  github_url('Bilal2453/luvit-meta'), -- https://github.com/Bilal2453/luvit-meta
})

if vim.g.have_nerd_font then require('nvim-web-devicons').setup() end
