-- https://github.com/echasnovski/mini.nvim

---@module 'lazy'
---@type LazySpec
return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup({ n_lines = 500 })

    local mini_bufremove = require('mini.bufremove')
    mini_bufremove.setup()
    local keymap = require('utils.keymap')
    keymap('<leader>bd', mini_bufremove.delete, { desc = '[D]elete buffer' })
    keymap('<leader>bw', mini_bufremove.wipeout, { desc = '[W]ipeout buffer' })
    keymap('<leader>bu', mini_bufremove.unshow, { desc = '[U]nshow buffer' })

    require('mini.diff').setup({
      view = {
        style = 'sign',
      },
    })

    require('mini.move').setup()

    local mini_statusline = require('mini.statusline')
    mini_statusline.setup({ use_icons = vim.g.have_nerd_font })
    ---@diagnostic disable-next-line: duplicate-set-field
    mini_statusline.section_location = function() return '%2l:%-2v' end

    require('mini.surround').setup()
  end,
}
