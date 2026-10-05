-- Plugin to improve viewing Markdown files in Neovim.

local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
packAdd({
  githubUrl('MeanderingProgrammer/render-markdown.nvim'), -- https://github.com/MeanderingProgrammer/render-markdown.nvim
})

require('render-markdown').setup({
  anti_conceal = { enabled = false },
  completions = { lsp = { enabled = true } },
})

local keymap = require('utils.keymap')
keymap(
  '<leader>mb',
  function() require('render-markdown').buf_toggle() end,
  { desc = '[B]uffer toggle render state' }
)
keymap(
  '<leader>mc',
  function() require('render-markdown').config() end,
  { desc = 'Diff [c]onfig and default' }
)
keymap(
  '<leader>md',
  function() require('render-markdown').debug() end,
  { desc = '[D]ebug current line' }
)
keymap('<leader>ml', function() require('render-markdown').log() end, { desc = 'Open [l]og file' })
keymap(
  '<leader>mp',
  function() require('render-markdown').preview() end,
  { desc = 'Show [p]review buffer to the side' }
)
keymap(
  '<leader>mt',
  function() require('render-markdown').toggle() end,
  { desc = '[T]oggle render state' }
)
