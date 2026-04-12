-- https://github.com/NickvanDyke/opencode.nvim

---@module 'lazy'
---@type LazySpec
return {
  'NickvanDyke/opencode.nvim',
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = false,
        stop = false,
        toggle = false,
      },
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    local keymap = require('utils.keymap')
    keymap(
      '<C-a>',
      function() require('opencode').command('session.half.page.up') end,
      { desc = 'Half page up' },
      { 'n', 'x' }
    )
    keymap(
      '<C-x>',
      function() require('opencode').command('session.half.page.down') end,
      { desc = 'Half page down' },
      { 'n', 'x' }
    )
    keymap('+', '<C-a>', { desc = 'Increment', noremap = true })
    keymap('-', '<C-x>', { desc = 'Decrement', noremap = true })
    keymap(
      '<leader>oa',
      function() require('opencode').ask('', { submit = true }) end,
      { desc = '[A]sk opencode' },
      { 'n', 'v', 'x' }
    )
    keymap(
      '<leader>oc',
      function() require('opencode').ask('@this: ', { submit = true }) end,
      { desc = 'Opencode ask with [c]ontext' },
      { 'n', 'v', 'x' }
    )
    keymap(
      '<leader>ol',
      function() return require('opencode').operator('@this ') .. '_' end,
      { desc = 'Add [l]ine to opencode', expr = true }
    )
    keymap(
      '<leader>or',
      function() return require('opencode').operator('@this ') end,
      { desc = 'Add [r]ange to opencode', expr = true },
      { 'n', 'x' }
    )
    keymap(
      '<leader>os',
      function() require('opencode').select() end,
      { desc = 'Execute opencode [s]elected action…' },
      { 'n', 'v', 'x' }
    )
  end,
}
