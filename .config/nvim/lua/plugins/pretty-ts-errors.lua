-- https://github.com/youyoumu/pretty-ts-errors.nvim
-- A Neovim plugin that enhances TypeScript errors by formatting them into readable, markdown-formatted.

---@module 'lazy'
---@type LazySpec
return {
  'youyoumu/pretty-ts-errors.nvim',
  config = function()
    require('pretty-ts-errors').setup({
      auto_open = false,
    })

    -- Add ts-plugin as a source
    require('pretty-ts-errors.utils').is_ts_source = function(source)
      return vim.tbl_contains({
        'tsserver',
        'ts',
        'typescript',
        'deno-ts',
        'ts-plugin',
      }, source)
    end

    local keymap = require('utils.keymap')
    keymap('<leader>te', function() require('pretty-ts-errors').show_formatted_error() end, { desc = 'Show TS [e]rror' })
    keymap('<leader>ta', function() require('pretty-ts-errors').open_all_errors() end, { desc = 'Show [a]ll TS errors' })
    keymap(
      '<leader>tt',
      function() require('pretty-ts-errors').toggle_auto_open() end,
      { desc = '[T]oggle TS error auto-display' }
    )
  end,
}
