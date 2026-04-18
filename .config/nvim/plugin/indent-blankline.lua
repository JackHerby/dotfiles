-- This plugin adds indentation guides to Neovim.

local github_url = require('utils.github_url')
vim.pack.add({
  github_url('lukas-reineke/indent-blankline.nvim'), -- https://github.com/lukas-reineke/indent-blankline.nvim
})

require('ibl').setup({
  whitespace = {
    highlight = { 'Whitespace', 'NonText' },
  },
})

-- Enable list mode to show white space characters.
vim.opt.list = true
vim.opt.listchars = {
  space = '·',
  tab = '󰌒 ',
  trail = '∘',
  extends = '',
  precedes = '',
  nbsp = '󱁐',
  eol = '󰘌',
}
