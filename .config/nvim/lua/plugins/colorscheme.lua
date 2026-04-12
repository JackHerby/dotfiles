-- https://github.com/ellisonleao/gruvbox.nvim

---@module 'lazy'
---@type LazySpec
return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  config = function()
    require('gruvbox').setup({
      contrast = 'hard',
    })
    vim.o.background = 'dark' -- or "light" for light mode
    vim.cmd('colorscheme gruvbox')
  end,
}
