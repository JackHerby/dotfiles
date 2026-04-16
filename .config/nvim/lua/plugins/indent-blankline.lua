-- https://github.com/lukas-reineke/indent-blankline.nvim
-- This plugin adds indentation guides to Neovim.

---@module 'lazy'
---@type LazySpec
return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    whitespace = {
      highlight = { 'Whitespace', 'NonText' },
    },
  },
  config = function(_, opts)
    require('ibl').setup(opts)
    -- Enable list mode to show whitespace characters
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
  end,
}
