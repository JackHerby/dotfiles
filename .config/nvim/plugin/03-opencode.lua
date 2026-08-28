-- Opencode integration for Neovim.

local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
packAdd({
  githubUrl('NickvanDyke/opencode.nvim'), -- https://github.com/NickvanDyke/opencode.nvim
})

---@type opencode.Opts
vim.g.opencode_opts = {
  events = {
    permissions = {
      enabled = false,
    },
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
keymap('<leader>oa', function() require('opencode').ask('') end, { desc = '[A]sk Opencode' }, { 'n', 'v', 'x' })
keymap(
  '<leader>oc',
  function() require('opencode').ask('@this: ') end,
  { desc = 'Opencode ask with [c]ontext' },
  { 'n', 'v', 'x' }
)
keymap(
  '<leader>ol',
  function() return require('opencode').operator('@this ') .. '_' end,
  { desc = 'Add [l]ine to Opencode', expr = true }
)
keymap(
  '<leader>or',
  function() return require('opencode').operator('@this ') end,
  { desc = 'Add [r]ange to Opencode', expr = true },
  { 'n', 'x' }
)
keymap(
  '<leader>os',
  function() require('opencode').select() end,
  { desc = 'Execute Opencode [s]elected action' },
  { 'n', 'v', 'x' }
)
keymap('+', '<C-a>', { desc = 'increment', noremap = true })
keymap('-', '<C-x>', { desc = 'decrement', noremap = true })
