-- https://github.com/mbbill/undotree

---@module 'lazy'
---@type LazySpec
return {
  'mbbill/undotree',
  event = 'VeryLazy',
  config = function()
    local keymap = require('utils.keymap')
    keymap('<leader>uu', vim.cmd.UndotreeToggle, { desc = 'Toggle [U]ndotree' })

    vim.g.undotree_WindowLayout = 4
    vim.g.undotree_SplitWidth = 50
    vim.g.undotree_DiffpanelHeight = 20
  end,
}
